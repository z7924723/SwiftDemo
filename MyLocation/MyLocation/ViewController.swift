//
//  ViewController.swift
//  MyLocation
//
//  Created by PinguMac on 2017/11/27.
//  Copyright © 2017年 PinguMac. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
  
  var myLocationMgr :CLLocationManager!
  var myMapView :MKMapView!

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    // Create location data
    myLocationMgr = CLLocationManager()
    myLocationMgr.delegate = self
    myLocationMgr.distanceFilter = kCLLocationAccuracyNearestTenMeters // update data after move ten meters
    myLocationMgr.desiredAccuracy = kCLLocationAccuracyBest
    
    // Create MapView
    let screenSize = UIScreen.main.bounds
    myMapView = MKMapView(frame: CGRect(x: 0,
                                        y: 20,
                                        width: screenSize.width,
                                        height: screenSize.height - 20))
    myMapView.delegate = self
    myMapView.mapType = .standard
    myMapView.showsUserLocation = true
    myMapView.isZoomEnabled = true // allow zoom in(out)
    
    self.view.addSubview(myMapView)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    // Get user author
    switch CLLocationManager.authorizationStatus() {
    case .notDetermined:
      myLocationMgr.requestWhenInUseAuthorization() // First time lanch app need to get authorize from user
      fallthrough
      
    case .authorizedWhenInUse:
      myLocationMgr.startUpdatingLocation() // Start location
    
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

  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    // Stop location
    myLocationMgr.stopUpdatingLocation()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let currentLocation: CLLocation = locations[0] as CLLocation
    print("\(currentLocation.coordinate.latitude)")
    print(", \(currentLocation.coordinate.longitude)")
    
    let center = CLLocationCoordinate2D(latitude: currentLocation.coordinate.latitude,
                                        longitude: currentLocation.coordinate.longitude)
    
    // paramater span means the range of map
    let region = MKCoordinateRegion(center: center, 
                                    span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    myMapView.setRegion(region, animated: true)
  }
}

