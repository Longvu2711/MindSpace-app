//
//  loadingView.swift
//  YappingApp
//
//  Created by Long Vu on 2/5/25.
//

import Foundation
import UIKit

private var loadingViewTag = 999_999

extension UIViewController {
  func showLoading() {
    if view.viewWithTag(loadingViewTag) != nil { return }
    
    let loadingView = UIView(frame: view.bounds)
    loadingView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
    loadingView.tag = loadingViewTag
    loadingView.isUserInteractionEnabled = true
    
    let activityIndicator = UIActivityIndicatorView(style: .large)
    activityIndicator.center = loadingView.center
    activityIndicator.startAnimating()
    
    loadingView.addSubview(activityIndicator)
    view.addSubview(loadingView)
  }
  
  func hideLoading() {
    if let loadingView = view.viewWithTag(loadingViewTag) {
      loadingView.removeFromSuperview()
    }
  }
}
