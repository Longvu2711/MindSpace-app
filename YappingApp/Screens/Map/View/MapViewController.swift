//
//  MapViewController.swift
//  YappingApp
//
//  Created by Long Vu on 16/4/25.
//

import UIKit
import MapKit

class MapViewController: BaseViewController {
  
  @IBOutlet weak var mapView: MKMapView!
  private let viewModel = MapViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupMap()
    bindViewModel()
  }
  
  private func setupMap() {
    mapView.delegate = self
    mapView.showsUserLocation = true
  }
  
  private func bindViewModel() {
    viewModel.onLocationUpdate = { [weak self] location in
      guard let self = self else { return }
      self.zoomTo(location)
    }
    
    viewModel.onLocationFail = { error in
      print("Location failed: \(error.localizedDescription)")
    }
    
    viewModel.requestUserLocation()
  }
  
  private func zoomTo(_ location: CLLocation) {
    let region = MKCoordinateRegion(center: location.coordinate,
                                    latitudinalMeters: 500,
                                    longitudinalMeters: 500)
    UIView.animate(withDuration: 1.2) {
      self.mapView.setRegion(region, animated: true)
    }
  }
}

extension MapViewController: MKMapViewDelegate {}
