//
//  ViewController.swift
//  MyLocationGoogleMap
//
//  Created by PinguMac on 2017/11/28.
//  Copyright © 2017年 PinguMac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = UIColor.white
    
    // Location Button
    let CameraBtn: UIButton = UIButton()
    CameraBtn.frame = CGRect(x: self.view.frame.size.width / 5,
                             y: self.view.frame.size.height / 2,
                             width: self.view.frame.size.width / 3,
                             height: 50)
    CameraBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
    CameraBtn.titleLabel?.adjustsFontSizeToFitWidth = true
    CameraBtn.setTitle("My Location", for: .normal)
    CameraBtn.setTitleColor(UIColor.white, for: .normal)
    CameraBtn.layer.cornerRadius = 10
    CameraBtn.backgroundColor = UIColor.darkGray
    CameraBtn.addTarget(self,
                        action: #selector(ViewController.LocateBtnAction(_:)),
                        for: UIControlEvents.touchUpInside)
    
    self.view.addSubview(CameraBtn)
  }
  
  @IBAction func LocateBtnAction(_ sender: UIButton){
    let mapViewCtrler = MapViewController()
    self.present(mapViewCtrler, animated: true, completion: nil)
  }
  
}
