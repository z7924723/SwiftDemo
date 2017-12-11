//
//  DashboardVC.swift
//  BottomNavigation
//
//  Created by PinguMac on 2017/12/11.
//  Copyright © 2017年 PinguMac. All rights reserved.
//

import UIKit

class DashboardVC: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    
    let fullScreenSize = UIScreen.main.bounds.size
    
    let dashLabel = UILabel(frame: CGRect(x: 0,
                                          y: fullScreenSize.height / 4,
                                          width: fullScreenSize.width,
                                          height: 80))
    dashLabel.text = "DashBoard"
    dashLabel.textColor = UIColor.yellow
    dashLabel.font = UIFont.systemFont(ofSize: 30)
    dashLabel.textAlignment = .center
    dashLabel.numberOfLines = 1
    self.view.addSubview(dashLabel)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

}
