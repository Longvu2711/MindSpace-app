//
//  SettingCell.swift
//  TwoFactorAuthentication
//
//  Created by Long Vu on 2/4/25.
//

import UIKit

class SettingCell: UITableViewCell {
  
  @IBOutlet weak var settingSwitch: UISwitch!
  @IBOutlet weak var settingLabel: UILabel!
  @IBOutlet weak var iconView: UIImageView!
  @IBOutlet weak var rightImage: UIImageView!
  
  var switchChanged: ((Bool) -> Void)?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    settingSwitch.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
    settingSwitch.onTintColor = UIColor.primarydark
    settingSwitch.tintColor = UIColor.systemGray
    settingSwitch.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
    settingLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
  }
  
  @objc private func switchValueChanged(_ sender: UISwitch) {
    switchChanged?(sender.isOn)
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  func configureCell(with item: SettingItem) {
    settingLabel.text = item.title
    iconView.image = item.icon
    switch item.type {
      case .navigation:
        rightImage.isHidden = false
        settingSwitch.isHidden = true
      case .toggle(let isOn):
        rightImage.isHidden = true
        settingSwitch.isHidden = false
        settingSwitch.isOn = isOn
    }
  }
  
}
