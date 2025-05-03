//
//  SettingModel.swift
//  TwoFactorAuthentication
//
//  Created by Long Vu on 1/4/25.
//

import Foundation
import UIKit

enum SettingType {
  case navigation(destination: String)
  case toggle(isOn: Bool)
}

struct SettingItem {
  let icon: UIImage?
  let title: String
  var type: SettingType
}
