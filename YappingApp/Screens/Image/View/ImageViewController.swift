//
//  ImageViewController.swift
//  YappingApp
//
//  Created by Long Vu on 16/4/25.
//

import UIKit
import Photos

final class ImageViewController: BaseViewController {
  
  // MARK: - Outlets
  @IBOutlet weak var collectionView: UICollectionView!
  
  // MARK: - Properties
  private let viewModel = ImageViewModel()
  private let cellIdentifier = "ImageCell"
  private let spacing: CGFloat = 5
  private let columns: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 5 : 3
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupCollectionView()
    bindViewModel()
    showLoading()
    viewModel.fetchAssets()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    setupCollectionLayout()
  }
  
  // MARK: - Setup
  private func setupCollectionView() {
    collectionView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
    collectionView.dataSource = self
    collectionView.delegate = self
  }
  
  private func setupCollectionLayout() {
    let layout = UICollectionViewFlowLayout()
    let totalSpacing = spacing * (columns + 1)
    let cellWidth = (collectionView.bounds.width - totalSpacing) / columns
    
    layout.itemSize = CGSize(width: cellWidth, height: cellWidth)
    layout.minimumLineSpacing = spacing
    layout.minimumInteritemSpacing = spacing
    collectionView.contentInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
    collectionView.collectionViewLayout = layout
  }
  
  private func calculateTargetSize() -> CGSize {
    let scale = UIScreen.main.scale
    let totalSpacing = spacing * (columns + 1)
    let cellWidth = (collectionView.bounds.width - totalSpacing) / columns
    return CGSize(width: cellWidth * scale, height: cellWidth * scale)
  }
  
  private func bindViewModel() {
    viewModel.onAssetsUpdated = { [weak self] in
      self?.collectionView.reloadData()
      self?.hideLoading()
    }
    viewModel.onPermissionDenied = { [weak self] in
      self?.hideLoading()
    }
  }
}

// MARK: - UICollectionViewDataSource
extension ImageViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.numberOfAssets()
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? ImageCell,
          let asset = viewModel.asset(at: indexPath.item)
    else {
      return UICollectionViewCell()
    }
    
    let targetSize = calculateTargetSize()
    
    viewModel.requestThumbnail(for: asset, targetSize: targetSize) { image in
      let duration = asset.mediaType == .video
      ? String(format: "%02d:%02d", Int(asset.duration) / 60, Int(asset.duration) % 60)
      : ""
      
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
      
      DispatchQueue.main.async {
        cell.configure(with: info)
      }
    }
    
    return cell
  }
}
