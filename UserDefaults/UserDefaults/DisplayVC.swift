//
//  DisplayVC.swift
//  UserDefaults
//
//  Created by PinguMac on 2017/12/18.
//  Copyright © 2017年 PinguMac. All rights reserved.
//

import UIKit

class DisplayVC: UIViewController {

  let fullSize = UIScreen.main.bounds.size

  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.white
    
    // Get default data
    let getUserDefaults = UserDefaults.standard
    
    // 顯示儲存資訊的 UILabel
    let infoLabel = UILabel(frame: CGRect(x: 0,
                                          y: 0,
                                          width: fullSize.width,
                                          height: 40))
    infoLabel.textColor = UIColor.brown
    infoLabel.textAlignment = .center
    infoLabel.center = CGPoint(x: fullSize.width * 0.5, y: fullSize.height * 0.25)
    
    if let nameInfo = getUserDefaults.object(forKey: "name") as? String {
      infoLabel.text = nameInfo
    } else {
      infoLabel.text = "Please input name"
      infoLabel.textColor = UIColor.red
    }
    
    self.view.addSubview(infoLabel)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}
