//
//  DefaultStorage.swift
//  YappingApp
//
//  Created by Long Vu on 12/4/25.
//

import Foundation

private struct DefaultStorageKeys {
  
}

protocol UserDefaultsProvider {	
  func set(_ value: Any?, forKey defaultName: String)
  func bool(forKey defaultName: String) -> Bool
  func double(forKey defaultName: String) -> Double
  func integer(forKey defaultName: String) -> Int
  func string(forKey defaultName: String) -> String?
  func date(forKey defaultName: String) -> Date?
  func arrInterger(forKey defaultName: String) -> [Int]?
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
  	
}

protocol DefaultsStorage {
  	
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
}
