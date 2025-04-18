//
//  ImageViewController.swift
//  YappingApp
//
//  Created by Long Vu on 16/4/25.
//

import UIKit

class ImageViewController: BaseViewController {
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    setupCollectionView()
  }
  
  private func setupCollectionView() {
    
    
  }
}
