//
//  BlankViewController.swift
//  YappingApp
//
//  Created by Long Vu on 16/4/25.
//

import UIKit

class BlankViewController: BaseViewController {
  
  @IBOutlet weak var menuView: MenuView!
  @IBOutlet weak var containerView: UIView!
  
  private let folderViewController = FolderViewController()
  private let imageViewController = ImageViewController()
  private let homeViewController = HomeViewController()
  private let settingViewController = SettingViewController()
  private let mapViewController = MapViewController()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    menuView.menuDelegate = self
    menuViewDidSelect(mode: .home)
  }
  
}

extension BlankViewController: MenuViewDelegate {
  func menuViewDidSelect( mode: MenuView.ViewMode ) {
    switch mode {
      case .folder:
        switchTo(folderViewController)
      case .home:
        switchTo(homeViewController)
      case .image:
        switchTo(imageViewController)
      case .map:
        switchTo(mapViewController)
      case .setting:
        switchTo(settingViewController)
    }
  }
}

private extension BlankViewController {
  func switchTo(_ viewController: UIViewController) {
    for child in children {
      child.view.removeFromSuperview()
      child.removeFromParent()
    }
    addChild(viewController)
    containerView.addSubview(viewController.view)
    viewController.view.frame = containerView.bounds
    viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    print("\(viewController) tapped")
  }
}
