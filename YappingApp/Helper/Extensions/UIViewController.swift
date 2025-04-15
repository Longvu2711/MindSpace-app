//
//  UIViewController.swift
//  YappingApp
//
//  Created by Long Vu on 15/4/25.
//

import Foundation
import UIKit

extension UIViewController {
  static func makeMe() -> Self {
    let name = String(describing: type(of: Self.self)).components(separatedBy: ".").first!
    let storyBoard = UIStoryboard(name: name, bundle: .main)
    let controller = storyBoard.instantiate(Self.self)
    return controller
  }
}

extension UIStoryboard {
  func instantiate<T: UIViewController>(_: T.Type) -> T {
    let id = String(describing: type(of: T.self)).components(separatedBy: ".").first!
    let controller = self.instantiateViewController(withIdentifier: id) as! T
    return controller
  }
}
