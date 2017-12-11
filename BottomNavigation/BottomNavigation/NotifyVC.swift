//
//  NotifyVC.swift
//  BottomNavigation
//
//  Created by PinguMac on 2017/12/11.
//  Copyright © 2017年 PinguMac. All rights reserved.
//

import UIKit

class NotifyVC: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    let fullScreenSize = UIScreen.main.bounds.size
    
    let notifyLabel = UILabel(frame: CGRect(x: 0,
                                            y: fullScreenSize.height / 4,
                                            width: fullScreenSize.width,
                                            height: 80))
    notifyLabel.text = "Notify"
    notifyLabel.textColor = UIColor.green
    notifyLabel.font = UIFont.systemFont(ofSize: 30)
    notifyLabel.textAlignment = .center
    notifyLabel.numberOfLines = 1
    
    self.view.addSubview(notifyLabel)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}
