//
//  MapViewController.swift
//  MyLocationGoogleMap
//
//  Created by PinguMac on 2017/11/28.
//  Copyright © 2017年 PinguMac. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {

  var myMapView: GMSMapView!
  var myLocationMgr: CLLocationManager!

  override func viewDidLoad() {
    super.viewDidLoad()

    GMSServices.provideAPIKey("AIzaSyAqAuWFzh9gB8TzaN7hs0Xv7suiz2NezFQ")

    // Create location data
    myLocationMgr = CLLocationManager()
    myLocationMgr.delegate = self
    myLocationMgr.requestWhenInUseAuthorization() // request user authorize
    myLocationMgr.distanceFilter = kCLLocationAccuracyNearestTenMeters // update data after move ten meters
    myLocationMgr.desiredAccuracy = kCLLocationAccuracyBest

    // Create MapView
    let screenSize = UIScreen.main.bounds
    let defaultCenter = CLLocationCoordinate2D(latitude: -32.725757, longitude: 21.481987)
    myMapView = GMSMapView(frame: CGRect(x: 0,
                                         y: 0,
                                         width: screenSize.width,
                                         height: screenSize.height))
    myMapView.delegate = self
    myMapView.mapType = .normal
    myMapView.camera = GMSCameraPosition(target: defaultCenter, zoom: 1, bearing: 0, viewingAngle: 0)
    self.view.addSubview(myMapView)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    // Get user author
    switch status {
    case .authorizedWhenInUse:
      myLocationMgr.startUpdatingLocation() // Start location
      myMapView.isMyLocationEnabled = true
      myMapView.settings.myLocationButton = true

    case .denied:
      let alertController = UIAlertController(title: "定位權限已關閉",
                                              message:"如要變更權限，請至 設定 > 隱私權 > 定位服務 開啟",
                                              preferredStyle: .alert)
      let okAction = UIAlertAction(title: "確認", style: .default, handler:nil)
      alertController.addAction(okAction)
      self.present(alertController, animated: true, completion: nil)

    default:
      break
    }
  }

  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let currentLocation: CLLocation = locations[0] as CLLocation
    print("Current Location: \(currentLocation.coordinate.latitude), \(currentLocation.coordinate.longitude)")

    if let location = locations.first {
      // Mark -
      CATransaction.begin()
      CATransaction.setValue(Int(2), forKey: kCATransactionAnimationDuration)
      myMapView.animate(toLocation: location.coordinate)
      myMapView.animate(toZoom: 12)
      CATransaction.commit()

//      myMapView.camera = GMSCameraPosition(target: location.coordinate,
//                                           zoom: 15,
//                                           bearing: 0,
//                                           viewingAngle: 0)
      myLocationMgr.stopUpdatingLocation()
    }
  }
}

