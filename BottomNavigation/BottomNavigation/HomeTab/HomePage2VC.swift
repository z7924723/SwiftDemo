//
//  HomePage2VC.swift
//  BottomNavigation
//
//  Created by PinguMac on 2017/12/11.
//  Copyright © 2017年 PinguMac. All rights reserved.
//

import UIKit

class HomePage2VC: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    let fullScreenSize = UIScreen.main.bounds.size
    self.view.backgroundColor = UIColor.white
    
    self.title = "Page 2"
    
    // Text Label
    let page2Label = UILabel(frame: CGRect(x: 0,
                                           y: fullScreenSize.height / 4,
                                           width: fullScreenSize.width,
                                           height: 80))
    page2Label.text = "Page 2"
    page2Label.textColor = UIColor.red
    page2Label.font = UIFont.systemFont(ofSize: 30)
    page2Label.textAlignment = .center
    page2Label.numberOfLines = 1
    self.view.addSubview(page2Label)
    
    //To page 3 button
    let toPage3Btn = UIButton(frame: CGRect(x: fullScreenSize.width / 3 + 12,
                                            y: page2Label.frame.maxY + 10,
                                            width: 120,
                                            height: 40))
    toPage3Btn.setTitle("Page 3", for: .normal)
    toPage3Btn.backgroundColor = UIColor.blue
    toPage3Btn.addTarget(self, action: #selector(HomePage2VC.toPage3BtnAction), for: .touchUpInside)
    self.view.addSubview(toPage3Btn)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func toPage3BtnAction() {
    self.navigationController!.pushViewController(HomePage3VC(), animated: true)
  }
}
