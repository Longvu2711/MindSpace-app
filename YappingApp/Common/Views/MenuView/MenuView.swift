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
    case setting
  }
  
  weak var menuDelegate: MenuViewDelegate?
  
  @IBOutlet weak var homeLabel: UILabel!
  @IBOutlet weak var folderLabel: UILabel!
  @IBOutlet weak var imageLabel: UILabel!
  @IBOutlet weak var settingLabel: UILabel!
  
  @IBOutlet weak var homeView: UIView!
  @IBOutlet weak var folderView: UIView!
  @IBOutlet weak var imageView: UIView!
  @IBOutlet weak var settingView: UIView!
  
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
  
  private func setupUI() {
    homeLabel.text = "home".localized()
    folderLabel.text = "folder".localized()
    imageLabel.text = "image".localized()
    settingLabel.text = "setting".localized()
    
    homeLabel.font = .systemFont(ofSize: 14, weight: .medium)
    folderLabel.font = .systemFont(ofSize: 14, weight: .medium)
    imageLabel.font = .systemFont(ofSize: 14, weight: .medium)
    settingLabel.font = .systemFont(ofSize: 14, weight: .medium)
  }

  private func freshUI() {
    
  }
  
  private func loadView(){
    let bundle = Bundle(for: type(of: self))
    let nib = UINib(nibName: String(describing: Self.self), bundle: bundle)
    guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {return}
    view.frame = self.bounds
    addSubview(view)
  }

  
}
