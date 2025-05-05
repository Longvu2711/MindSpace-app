//
//  MapViewModel.swift
//  YappingApp
//
//  Created by Long Vu on 6/5/25.
//

import Foundation
import CoreLocation

final class MapViewModel {
  private let locationService = LocationService()
  var onLocationUpdate: ((CLLocation) -> Void)?
  var onLocationFail: ((Error) -> Void)?
  
  init() {
    locationService.delegate = self
  }
  
  func requestUserLocation() {
    locationService.requestLocationAccess()
    locationService.startUpdating()
  }
  
  func stopLocationUpdates() {
    locationService.stopUpdating()
  }
}

extension MapViewModel: LocationServiceDelegate {
  func locationService(didUpdateLocation location: CLLocation) {
    onLocationUpdate?(location)
  }
  
  func locationService(didFailWithError error: Error) {
    onLocationFail?(error)
  }
}
