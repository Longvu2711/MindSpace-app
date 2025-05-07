//
//  Constants.swift
//  YappingApp
//
//  Created by Long Vu on 11/4/25.
//

import Foundation

struct Constants {
  static let discordWebhookURL: String = {
    guard let url = Bundle.main.infoDictionary?["DISCORD_WEBHOOK_URL"] as? String else {
      fatalError("DISCORD_WEBHOOK_URL failed")
    }
    return url
  }()
}
