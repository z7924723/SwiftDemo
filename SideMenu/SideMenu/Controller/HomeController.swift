//
//  ViewController.swift
//  SideMenu
//
//  Created by PinguMac on 2018/1/2.
//  Copyright © 2018年 PinguMac. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view, typically from a nib.
    let leftBtn = UIBarButtonItem(image: UIImage(named:"hamburger"),
                                  style: .plain,
                                  target: self,
                                  action: #selector(HomeController.leftBarBtnAct))
    self.navigationItem.leftBarButtonItem = leftBtn
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  lazy var settingLancher: SettingLancher = {
    let launcher = SettingLancher()
    launcher.homeVC = self
    return launcher
  }()
  
  @IBAction func leftBarBtnAct() {
    settingLancher.showSetting()
  }
  
  func showControllerForSetting(setting: Setting) {
    let settingsVC = UIViewController()
    if setting.labelName != "" {
     settingsVC.navigationItem.title = setting.labelName
     navigationController?.pushViewController(settingsVC, animated: true)
    }
  }

}
