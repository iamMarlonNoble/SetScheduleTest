//
//  LocationService.swift
//  SetScheduleTest
//
//  Created by Marlon on 3/10/21.
//

import CoreLocation

protocol LocationService: AnyObject {
  var didUpdateLocation: ((CLLocationCoordinate2D) -> Void)? { get set }
}

class LocationServiceDefault: NSObject, LocationService {
  
  var didUpdateLocation: ((CLLocationCoordinate2D) -> Void)?
  
  private let locationManager = CLLocationManager()
  
  override init() {
    super.init()
    setup()
  }
  
  private func setup() {
    locationManager.requestWhenInUseAuthorization()
    
    startUpdating()
  }
  
  private func startUpdating() {
    guard CLLocationManager.locationServicesEnabled() else { return }
    
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    locationManager.startUpdatingLocation()
  }
  
}

extension LocationServiceDefault: CLLocationManagerDelegate {
  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    startUpdating()
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
    didUpdateLocation?(locValue)
  }
}
