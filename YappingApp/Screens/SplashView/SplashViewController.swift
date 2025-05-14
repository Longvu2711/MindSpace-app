//
//  SplashViewController.swift
//  YappingApp
//
//  Created by Long Vu on 11/4/25.
//

import Foundation
import UIKit

class SplashViewController: BaseViewController {
  
  private var secondsRemaining: Int = 2
  private var countdownTimer: Timer?

  @IBOutlet weak var logoImageView: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    print("never say ...")
    startTimer()
  }
  
  @objc func decrementCounter() {
    secondsRemaining -= 1
    if secondsRemaining <= 0 {
      countdownTimer?.invalidate()
      countdownTimer = nil
      startMainScreen()
    }
  }
  
  func stopTimer() {
    countdownTimer?.invalidate()
    countdownTimer = nil
  }
  
  func startTimer() {
    countdownTimer = Timer.scheduledTimer(
      timeInterval: 1.0,
      target: self,
      selector: #selector(SplashViewController.decrementCounter),
      userInfo: nil,
      repeats: true)
  }
  
  private func startMainScreen() {
    stopTimer()
    var mainViewController: UIViewController
    mainViewController = BlankViewController()
    guard let keyWindow = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first else { return }
    let navigationController = UINavigationController(rootViewController: mainViewController)
    UIView.transition(with: keyWindow,
                      duration: 0.5,
                      options: RootControllerPresenterAnimation.flipFromRight.animationOptions()!,
                      animations: {
      keyWindow.rootViewController = navigationController
    },
                      completion: { _ in
    })
  }
  
}

enum RootControllerPresenterAnimation {
  case none, crossDissolve, flipFromLeft, flipFromRight
  
  func animationOptions() -> UIView.AnimationOptions? {
    switch self {
      case .none:
        return nil
      case .crossDissolve:
        return .transitionCrossDissolve
      case .flipFromLeft:
        return .transitionFlipFromLeft
      case .flipFromRight:
        return .transitionFlipFromRight
    }
  }
  
  func duration() -> Double {
    switch self {
      default:
        return 0.5
    }
  }
  
}
