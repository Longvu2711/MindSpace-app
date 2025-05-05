//
//  DefaultStorage.swift
//  YappingApp
//
//  Created by Long Vu on 12/4/25.
//

import Foundation

private struct DefaultsStorageKeys {
  static let isFirstLaunchKey = "isFirstLaunchKey"
  static let pushNotificationKey = "pushNotificationKey"
  static let currentLanguageKey = "currentLanguageKey"
}

protocol UserDefaultsProvider {	
  func set(_ value: Any?, forKey defaultName: String)
  func bool(forKey defaultName: String) -> Bool
  func double(forKey defaultName: String) -> Double
  func integer(forKey defaultName: String) -> Int
  func string(forKey defaultName: String) -> String?
  func date(forKey defaultName: String) -> Date?
  func arrInterger(forKey defaultName: String) -> [Int]?
  func object(forKey defaultName: String) -> Any?
}

extension UserDefaults: UserDefaultsProvider {
  func date (forKey defaultName: String) -> Date? {
    guard let date = value(forKey: defaultName) as? Date else { return nil }
    return date
  }
  
  func arrInterger(forKey defaultName: String) -> [Int]? {
    guard let arrInt = value(forKey: defaultName) as? [Int]  else { return nil }
    return arrInt
  }
  
//  func object(forKey defaultName: String) -> Any? {
//    return object(forKey: defaultName)
//  }
  	
}

protocol DefaultsStorage {
  var isFirstLaunch: Bool { get  set}
  var pushNotification: Bool { get  set}
  var currentLanguage: String { get set }
}

class DefaultStorageImpl: DefaultsStorage {
  
  private let defaults: UserDefaultsProvider
  private var todayDateString: String {
    let date = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyyMMdd"
    let dateString = dateFormatter.string(from: date)
    return dateString
  }
  
  init(userDefaultsProvider: UserDefaultsProvider = UserDefaults.standard) {
    defaults = userDefaultsProvider
  }
  
  var isFirstLaunch: Bool {
    get { return !defaults.bool(forKey: DefaultsStorageKeys.isFirstLaunchKey)}
    set { defaults.set(!newValue, forKey: DefaultsStorageKeys.isFirstLaunchKey)}
  }
  
  var pushNotification: Bool {
    get {
      if defaults.object(forKey: DefaultsStorageKeys.pushNotificationKey) == nil {
        return true
      }
      return defaults.bool(forKey: DefaultsStorageKeys.pushNotificationKey)
    }
    set {
      defaults.set(newValue, forKey: DefaultsStorageKeys.pushNotificationKey)
    }
  }
  
  var currentLanguage: String {
    get {
      if let languageCode = defaults.string(forKey: DefaultsStorageKeys.currentLanguageKey) {
        return languageCode
      }
      return "en"
    }
    set {
      defaults.set(newValue, forKey: DefaultsStorageKeys.currentLanguageKey)
    }
  }
  
}
