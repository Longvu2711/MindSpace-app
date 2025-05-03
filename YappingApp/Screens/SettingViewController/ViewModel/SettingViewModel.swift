//
//  SettingViewModel.swift
//  TwoFactorAuthentication
//
//  Created by Long Vu on 1/4/25.
//

import Foundation
import UIKit

class SettingsViewModel {
  var settings: [SettingItem] = [
    SettingItem(
      icon: UIImage(resource: .icSetting1), title: "setting_account_recently".localized(), type: .navigation(destination: "DeletedAccountsView" )),
    SettingItem(icon: UIImage(resource: .icSetting2), title: "setting_lock_password".localized(), type: .navigation(destination: "PasswordLockView")),
    SettingItem(icon: UIImage(resource: .icSetting3), title: "setting_backup_and_restore".localized(), type: .toggle(isOn: false)),
    SettingItem(icon: UIImage(resource: .icSetting4), title: "setting_dark_mode".localized(), type: .toggle(isOn: false)),
    SettingItem(icon: UIImage(resource: .icSetting5), title: "setting_disable_screen_capture".localized(), type: .toggle(isOn: true)),
    SettingItem(icon: UIImage(resource: .icSetting6), title: "setting_language".localized(), type: .navigation(destination: "LanguageView"))
  ]
}
