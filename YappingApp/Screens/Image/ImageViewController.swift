//
//  ImageViewController.swift
//  YappingApp
//
//  Created by Long Vu on 16/4/25.
//

import UIKit
import Photos

class ImageViewController: BaseViewController {
  
  // MARK: - Outlets
  @IBOutlet weak var collectionView: UICollectionView!
  
  // MARK: - Properties
  private var imageAssets: [PHAsset] = []
  private let cellIdentifier = "ImageCell"
  private let spacing: CGFloat = 20
  
  // MARK: - Lifecycle Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    setupCollectionView()
    fetchAssets()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    setupCollectionLayout()
  }
  
  // MARK: - Setup Methods
  private func setupCollectionView() {
    collectionView.register(UINib(nibName: cellIdentifier, bundle: nil),
                            forCellWithReuseIdentifier: cellIdentifier)
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.contentInset = UIEdgeInsets(top: spacing,
                                               left: spacing,
                                               bottom: spacing,
                                               right: spacing)
  }
  
  private func setupCollectionLayout() {
    let layout = UICollectionViewFlowLayout()
    let numberOfColumns = getNumberOfColumns()
    let cellWidth = calculateCellWidth(numberOfColumns: numberOfColumns)
    
    layout.itemSize = CGSize(width: cellWidth, height: cellWidth)
    layout.minimumInteritemSpacing = spacing
    layout.minimumLineSpacing = spacing
    
    collectionView.collectionViewLayout = layout
  }
  
  // MARK: - Helper Methods
  private func getNumberOfColumns() -> CGFloat {
    return UIDevice.current.userInterfaceIdiom == .pad ? 4 : 2
  }
  
  private func calculateCellWidth(numberOfColumns: CGFloat) -> CGFloat {
    let totalSpacing = spacing * (numberOfColumns + 1)
    return (collectionView.bounds.width - totalSpacing) / numberOfColumns
  }
  
  private func getTargetSize(for width: CGFloat) -> CGSize {
    let scale = UIScreen.main.scale
    return CGSize(width: width * scale, height: width * scale)
  }
  
  // MARK: - Data Methods
  private func fetchAssets() {
    showLoading()
    
    PHPhotoLibrary.requestAuthorization { [weak self] status in
      guard let self = self else { return }
      
      guard status == .authorized || status == .limited else {
        DispatchQueue.main.async {
          self.hideLoading()
        }
        return
      }
      
      let fetchOptions = PHFetchOptions()
      fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
      let fetchResult = PHAsset.fetchAssets(with: fetchOptions)
      
      var assets: [PHAsset] = []
      fetchResult.enumerateObjects { asset, _, _ in
        if asset.mediaType == .image || asset.mediaType == .video {
          assets.append(asset)
        }
      }
      
      DispatchQueue.main.async {
        self.imageAssets = assets
        self.collectionView.reloadData()
        self.hideLoading()
      }
    }
  }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension ImageViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return imageAssets.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? ImageCell else {
      return UICollectionViewCell()
    }
    
    let asset = imageAssets[indexPath.item]
    configureCell(cell, with: asset)
    
    return cell
  }
  
  private func configureCell(_ cell: ImageCell, with asset: PHAsset) {
    let manager = PHImageManager.default()
    let options = PHImageRequestOptions()
    options.isSynchronous = false
    options.deliveryMode = .highQualityFormat
    
    let numberOfColumns = getNumberOfColumns()
    let cellWidth = calculateCellWidth(numberOfColumns: numberOfColumns)
    let targetSize = getTargetSize(for: cellWidth)
    
    manager.requestImage(for: asset,
                         targetSize: targetSize,
                         contentMode: .aspectFill,
                         options: options) { [weak self] image, _ in
      guard self != nil else { return }
      
      let duration = asset.mediaType == .video ?
      String(format: "%02d:%02d", Int(asset.duration) / 60, Int(asset.duration) % 60) : ""
      
      let resource = PHAssetResource.assetResources(for: asset).first
      let size = resource?.value(forKey: "fileSize") as? Int64 ?? 0
      
      let info = AssetInfo(
        thumnail: image,
        size: Double(size),
        lenght: duration,
        url: URL(fileURLWithPath: ""),
        creationDate: asset.creationDate ?? Date(),
        asset: asset
      )
      
      cell.configure(with: info)
    }
  }
}
