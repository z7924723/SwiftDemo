//
//  ViewController.swift
//  SharkDetect
//
//  Created by PinguMac on 2018/1/10.
//  Copyright © 2018年 PinguMac. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController {

  let imgArray = ["01.jpg", "02.jpg", "03.jpg", "04.jpg", "05.jpg", "06.jpg"]
  
  let imgView: UIImageView = {
    let imageView = UIImageView()
    return imageView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    let ScreenSize = UIScreen.main.bounds.size
    self.view.backgroundColor = UIColor.white
    
    imgView.image = UIImage(named: imgArray[Int(arc4random_uniform(6))])
    imgView.frame = CGRect(x: 0,
                           y: 0,
                           width: ScreenSize.width,
                           height: ScreenSize.height / 2)
    imgView.center = CGPoint(x: ScreenSize.width * 0.5,
                             y: ScreenSize.height * 0.5)
    self.view.addSubview(imgView)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
    updateImage()
    AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))    
  }
  
  func updateImage() {
    var randIndex = Int(arc4random_uniform(6))
    imgView.image = UIImage(named: imgArray[randIndex])
  }
}

