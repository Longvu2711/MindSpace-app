//
//  LocationService.swift
//  YappingApp
//
//  Created by Long Vu on 6/5/25.
//

import Foundation

import Foundation
import CoreLocation

protocol LocationServiceDelegate: AnyObject {
  func locationService(didUpdateLocation location: CLLocation)
  func locationService(didFailWithError error: Error)
}

class LocationService: NSObject {
  private let locationManager = CLLocationManager()
  weak var delegate: LocationServiceDelegate?
  
  override init() {
    super.init()
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
  }
  
  func requestLocationAccess() {
    locationManager.requestWhenInUseAuthorization()
  }
  
  func startUpdating() {
    locationManager.startUpdatingLocation()
  }
  
  func stopUpdating() {
    locationManager.stopUpdatingLocation()
  }
}

extension LocationService: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.last else { return }
    delegate?.locationService(didUpdateLocation: location)
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    delegate?.locationService(didFailWithError: error)
  }
}
