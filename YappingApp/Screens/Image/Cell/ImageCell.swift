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

struct AssetInfo {
  let thumnail: UIImage?
  let size: Double
  let lenght: String
  let url: URL
  let creationDate: Date
  let asset: PHAsset
}

class ImageCell: UICollectionViewCell {

  @IBOutlet weak var cellView: UIView!
  
  @IBOutlet weak var videoLength: UILabel!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var originSize: UILabel!
  @IBOutlet weak var infoView: UIView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setupUI()
  }
  
  private func setupUI() {
    setupShadow()
    setupInfoView()
    setupImageView()
    cellView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      cellView.topAnchor.constraint(equalTo: contentView.topAnchor),
      cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
    ])
  }
  
  private func setupShadow() {
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOpacity = 0.3
    layer.shadowOffset = CGSize(width: 0, height: 4)
    layer.shadowRadius = 6
    layer.masksToBounds = false
  }
  
  private func setupInfoView() {
    infoView.layer.cornerRadius = 16
    infoView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    infoView.layer.masksToBounds = true
  }
  
  private func setupImageView() {
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
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
  
  func configure(with asset: AssetInfo) {
    imageView.image = asset.thumnail
    videoLength.text = asset.lenght
    videoLength.isHidden = asset.lenght.isEmpty
    originSize.text = ByteCountFormatter.string(fromByteCount: Int64(asset.size), countStyle: .file)
    infoView.isHidden = false
  }
  
  private func formattedSize(_ size: Double) -> String {
    let formatter = ByteCountFormatter()
    formatter.allowedUnits = [.useMB]
    formatter.countStyle = .file
    return formatter.string(fromByteCount: Int64(size))
  }
}

