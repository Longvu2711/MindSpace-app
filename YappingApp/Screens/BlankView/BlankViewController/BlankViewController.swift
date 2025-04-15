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
  
  override func viewDidLoad() {
    super.viewDidLoad()

    menuView.layer.cornerRadius = 18
    menuView.clipsToBounds = true
  }
  
  

  
}
