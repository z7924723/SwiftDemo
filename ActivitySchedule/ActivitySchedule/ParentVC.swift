//
//  ViewController.swift
//  ActivitySchedule
//
//  Created by PinguMac on 2017/12/13.
//  Copyright © 2017年 PinguMac. All rights reserved.
//

import UIKit

class ParentVC: UIViewController {
  
  var datePicker: UIDatePicker!
  var datePickLab: UILabel!
  var timePickLab: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    let fullScreenSize = UIScreen.main.bounds.size
    
    let backGroundImg = UIImageView(frame: CGRect(x: 0,
                                                  y: 0,
                                                  width: fullScreenSize.width,
                                                  height: fullScreenSize.height))
    backGroundImg.image = UIImage(named: "teddy.jpg")
    self.view.addSubview(backGroundImg)
    
    // create child view controller
    let childViewCtrl = ChildVC()
    addChildViewController(childViewCtrl)
    self.view.addSubview(childViewCtrl.view)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}
