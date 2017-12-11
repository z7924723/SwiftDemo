//
//  HomePage3VC.swift
//  BottomNavigation
//
//  Created by PinguMac on 2017/12/11.
//  Copyright © 2017年 PinguMac. All rights reserved.
//

import UIKit

class HomePage3VC: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    let fullScreenSize = UIScreen.main.bounds.size
    self.view.backgroundColor = UIColor.white
    
    self.title = "Page 3"
    
    // Page Label
    let page3Label = UILabel(frame: CGRect(x: 0,
                                           y: fullScreenSize.height / 4,
                                           width: fullScreenSize.width,
                                           height: 80))
    page3Label.text = "Page 3"
    page3Label.textColor = UIColor.red
    page3Label.font = UIFont.systemFont(ofSize: 30)
    page3Label.textAlignment = .center
    page3Label.numberOfLines = 1
    self.view.addSubview(page3Label)
    
    //To home button
    let toHomeBtn = UIButton(frame: CGRect(x: fullScreenSize.width / 3 + 12,
                                           y: page3Label.frame.maxY + 10,
                                           width: 120,
                                           height: 40))
    toHomeBtn.setTitle("Home", for: .normal)
    toHomeBtn.backgroundColor = UIColor.blue
    toHomeBtn.addTarget(self, action: #selector(HomePage3VC.toHomeBtnAction), for: .touchUpInside)
    self.view.addSubview(toHomeBtn)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func toHomeBtnAction() {
    self.navigationController!.popToRootViewController(animated: true)
  }
}
