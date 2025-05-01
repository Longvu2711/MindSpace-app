//
//  ImageViewController.swift
//  YappingApp
//
//  Created by Long Vu on 16/4/25.
//

import UIKit
import Photos

class ImageViewController: BaseViewController {
  
  @IBOutlet weak var collectionView: UICollectionView!
  private var imageAssets: [PHAsset] = []
  private var isSetupDone = false
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    if !isSetupDone {
      isSetupDone = true
      setupCollectionView()
      fetchAssets()
    }
  }
  
  private func setupCollectionView() {
    collectionView.register(UINib(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "ImageCell")
    collectionView.dataSource = self
    collectionView.delegate = self
  }

  private func fetchAssets() {
    self.showLoading()
    
    PHPhotoLibrary.requestAuthorization { status in
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


extension ImageViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return imageAssets.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImageCell else {
      return UICollectionViewCell()
    }
    
    let asset = imageAssets[indexPath.item]
    let manager = PHImageManager.default()
    let options = PHImageRequestOptions()
    options.deliveryMode = .fastFormat
    options.resizeMode = .fast
    options.isSynchronous = false
    
    manager.requestImage(for: asset, targetSize: CGSize(width: 150, height: 150), contentMode: .aspectFill, options: options) { image, _ in
      cell.imageView.image = image
      cell.videoLength.isHidden = (asset.mediaType != .video)
      if asset.mediaType == .video {
        let duration = Int(asset.duration)
        let minutes = duration / 60
        let seconds = duration % 60
        cell.videoLength.text = String(format: "%02d:%02d", minutes, seconds)
      }
    }
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let padding: CGFloat = 10
    let itemsPerRow: CGFloat = 3
    let totalPadding = padding * (itemsPerRow + 1)
    let itemWidth = (collectionView.bounds.width - totalPadding) / itemsPerRow
    return CGSize(width: itemWidth, height: itemWidth)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 10
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 10
  }
}
