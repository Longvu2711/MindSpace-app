//
//  ImageCell.swift
//  YappingApp
//
//  Created by Long Vu on 19/4/25.
//

import UIKit
import AVFoundation
import Photos

struct ImageInfo {
  let asset: PHAsset
  let thumbnail: UIImage?
  let creationDate: Date
  let url: URL
  let size: Double
}

struct VideoInfo {
  let url: URL
  let size: Double
  let thumbnail: UIImage?
  let length: String
}

class ImageCell: UICollectionViewCell {

  @IBOutlet weak var videoLength: UILabel!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var originSize: UILabel!
  @IBOutlet weak var infoView: UIView!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
  
  func configure(with image: ImageInfo) {
    imageView.image = image.thumbnail
    videoLength.isHidden = true
    originSize.text = ByteCountFormatter.string(fromByteCount: Int64(image.size), countStyle: .file)
    infoView.isHidden = false
  }
  
  func configure(with video: VideoInfo) {
    imageView.image = video.thumbnail
    videoLength.text = video.length
    videoLength.isHidden = false
    originSize.text = ByteCountFormatter.string(fromByteCount: Int64(video.size), countStyle: .file)
    infoView.isHidden = false
  }
  
  private func formattedSize(_ size: Double) -> String {
    let formatter = ByteCountFormatter()
    formatter.allowedUnits = [.useMB]
    formatter.countStyle = .file
    return formatter.string(fromByteCount: Int64(size))
  }
}

