//
//  ImageViewModel.swift
//  YappingApp
//
//  Created by Long Vu on 6/5/25.
//

import Photos
import UIKit

class ImageViewModel {
  
  private(set) var fetchResult: PHFetchResult<PHAsset>?
  private let imageManager = PHCachingImageManager()
  private let imageOptions: PHImageRequestOptions = {
    let options = PHImageRequestOptions()
    options.deliveryMode = .opportunistic
    options.resizeMode = .fast
    options.isNetworkAccessAllowed = false
    return options
  }()
  
  var onAssetsUpdated: (() -> Void)?
  var onPermissionDenied: (() -> Void)?
  
  func fetchAssets() {
    PHPhotoLibrary.requestAuthorization { [weak self] status in
      guard let self else { return }
      
      guard status == .authorized || status == .limited else {
        DispatchQueue.main.async {
          self.onPermissionDenied?()
        }
        return
      }
      
      let fetchOptions = PHFetchOptions()
      fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
      let result = PHAsset.fetchAssets(with: fetchOptions)
      
      DispatchQueue.main.async {
        self.fetchResult = result
        self.onAssetsUpdated?()
      }
    }
  }
  
  func asset(at index: Int) -> PHAsset? {
    return fetchResult?.object(at: index)
  }
  
  func numberOfAssets() -> Int {
    return fetchResult?.count ?? 0
  }
  
  func requestThumbnail(for asset: PHAsset, targetSize: CGSize, completion: @escaping (UIImage?) -> Void) {
    imageManager.requestImage(for: asset,
                              targetSize: targetSize,
                              contentMode: .aspectFill,
                              options: imageOptions) { image, _ in
      completion(image)
    }
  }
}
