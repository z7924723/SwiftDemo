//
//  ViewController.swift
//  BottomNavigation
//
//  Created by PinguMac on 2017/12/11.
//  Copyright © 2017年 PinguMac. All rights reserved.
//

import UIKit

class HomePageVC: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    let fullScreenSize = UIScreen.main.bounds.size
    self.view.backgroundColor = UIColor.white
    
    self.navigationController?.navigationBar.topItem?.title = "Home"
    
    // Page Label
    let homeLabel = UILabel(frame: CGRect(x: 0,
                                          y: fullScreenSize.height / 4,
                                          width: fullScreenSize.width,
                                          height: 80))
    homeLabel.text = "Home"
    homeLabel.textColor = UIColor.red
    homeLabel.font = UIFont.systemFont(ofSize: 30)
    homeLabel.textAlignment = .center
    homeLabel.numberOfLines = 1
    self.view.addSubview(homeLabel)
    
    //To page 2 button
    let toPage2Btn = UIButton(frame: CGRect(x: fullScreenSize.width / 3 + 12,
                                            y: homeLabel.frame.maxY + 10,
                                            width: 120,
                                            height: 40))
    toPage2Btn.setTitle("Page 2", for: .normal)
    toPage2Btn.backgroundColor = UIColor.blue
    toPage2Btn.addTarget(self, action: #selector(HomePageVC.toPage2BtnAction), for: .touchUpInside)
    self.view.addSubview(toPage2Btn)
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func toPage2BtnAction() {
    self.navigationController!.pushViewController(HomePage2VC(), animated: true)
  }
}

