//
//  MenuView.swift
//  YappingApp
//
//  Created by Long Vu on 15/4/25.
//

import UIKit

protocol MenuViewDelegate: AnyObject {
  func menuViewDidSelect(mode: MenuView.ViewMode)
}

class MenuView: UIView {
  
  enum ViewMode {
    case home
    case folder
    case image
    case map
    case setting
  }
  
  weak var menuDelegate: MenuViewDelegate?
  
  @IBOutlet weak var homeLabel: UILabel!
  @IBOutlet weak var folderLabel: UILabel!
  @IBOutlet weak var imageLabel: UILabel!
  @IBOutlet weak var globeLabel: UILabel!
  @IBOutlet weak var settingLabel: UILabel!
  
  @IBOutlet weak var homeView: UIView!
  @IBOutlet weak var folderView: UIView!
  @IBOutlet weak var imageView: UIView!
  @IBOutlet weak var globeView: UIView!
  @IBOutlet weak var settingView: UIView!
  
  @IBOutlet weak var folderImage: UIImageView!
  @IBOutlet weak var photoImage: UIImageView!
  @IBOutlet weak var homeImage: UIImageView!
  @IBOutlet weak var globeImage: UIImageView!
  @IBOutlet weak var settingImage: UIImageView!

  private var selectedView: ViewMode = .home {
    didSet {
      freshUI()
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupUI()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    self.layer.cornerRadius = 16
    self.clipsToBounds = true
  }
  
  private func setupUI() {
    self.clipsToBounds = true
    self.layer.cornerRadius = 16
    loadView()
  
    homeLabel.text = "home".localized()
    folderLabel.text = "folder".localized()
    imageLabel.text = "image".localized()
    globeLabel.text = "map".localized()
    settingLabel.text = "setting".localized()
    
    let labels = [homeLabel, folderLabel, imageLabel, globeLabel ,settingLabel]
    labels.forEach { $0?.font = .systemFont(ofSize: 12, weight: .medium) }
    
    [homeLabel, folderLabel, imageLabel, globeLabel, settingLabel,
     homeImage, folderImage, photoImage, globeImage, settingImage].forEach {
      $0?.isUserInteractionEnabled = false
    }
    let homeTap = UITapGestureRecognizer(target: self, action: #selector(didTapHome))
    let folderTap = UITapGestureRecognizer(target: self, action: #selector(didTapFolder))
    let imageTap = UITapGestureRecognizer(target: self, action: #selector(didTapImage))
    let globeTap = UITapGestureRecognizer(target: self , action: #selector(didTapGlobe))
    let settingTap = UITapGestureRecognizer(target: self, action: #selector(didTapSetting))
    
    homeView.addGestureRecognizer(homeTap)
    folderView.addGestureRecognizer(folderTap)
    imageView.addGestureRecognizer(imageTap)
    settingView.addGestureRecognizer(settingTap)
    globeView.addGestureRecognizer(globeTap)
    
    homeView.isUserInteractionEnabled = true
    folderView.isUserInteractionEnabled = true
    imageView.isUserInteractionEnabled = true
    settingView.isUserInteractionEnabled = true
    freshUI()
  }

  private func freshUI() {
    let labels = [
      (homeLabel, homeImage, ViewMode.home),
      (folderLabel, folderImage, .folder),
      (imageLabel, photoImage , .image),
      (globeLabel, globeImage , .map) ,
      (settingLabel, settingImage, .setting)
    ]
    for (label, image, mode) in labels {
      label?.textColor = (mode == selectedView) ? UIColor.systemBlue : UIColor.gray
      image?.tintColor = (mode == selectedView) ? UIColor.systemBlue : UIColor.gray
    }
  }
  
  private func loadView(){
    let bundle = Bundle(for: type(of: self))
    let nib = UINib(nibName: String(describing: Self.self), bundle: bundle)
    guard let contentView = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return }
    contentView.frame = bounds
    contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    contentView.clipsToBounds = true
    contentView.layer.cornerRadius = 18
    addSubview(contentView)
  }
  
  @objc private func didTapHome() {
    selectedView = .home
    menuDelegate?.menuViewDidSelect(mode: .home)
  }
  
  @objc private func didTapFolder() {
    selectedView = .folder
    menuDelegate?.menuViewDidSelect(mode: .folder)
  }
  
  @objc private func didTapImage() {
    selectedView = .image
    menuDelegate?.menuViewDidSelect(mode: .image)
  }
  
  @objc private func didTapGlobe() {
    selectedView = .map
    menuDelegate?.menuViewDidSelect(mode: .map)
  }
  @objc private func didTapSetting() {
    selectedView = .setting
    menuDelegate?.menuViewDidSelect(mode: .setting)
  }

  
}
