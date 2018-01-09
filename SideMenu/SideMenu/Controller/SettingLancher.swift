//
//  SettingLancher.swift
//  SideMenu
//
//  Created by PinguMac on 2018/1/3.
//  Copyright © 2018年 PinguMac. All rights reserved.
//

import UIKit

class Setting: NSObject {
  let labelName: String
  let imageName: String
  
  init(labelName: String, imageName: String) {
    self.labelName = labelName
    self.imageName = imageName
  }
}

class SettingLancher: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  let backView = UIView()
  
  let collectView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.backgroundColor = UIColor.white
    return cv
  }()
  
  let cellId = "cellId"
  let cellHeight: CGFloat = 50
  let settings: [Setting] = {
    return [Setting(labelName: "Settings", imageName: "setting"),
            Setting(labelName: "Term and Privacy Policy", imageName: "privacy"),
            Setting(labelName: "Send Feedback", imageName: "feedback"),
            Setting(labelName: "Help", imageName: "help"),
            Setting(labelName: "Switch Account", imageName: "account")
           ]
    }()
  
  weak var homeVC: HomeController?
  
  override init() {
    super.init()
    
    collectView.register(SettingCell.self, forCellWithReuseIdentifier: cellId)
    collectView.delegate = self
    collectView.dataSource = self
  }
  
  func showSetting() {
    if let window = UIApplication.shared.keyWindow {
      backView.backgroundColor = UIColor(white: 0, alpha: 0.5)
      backView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
      
      backView.frame = window.frame
      window.addSubview(backView)
      
      let collYPossion = statusBarHeight() + naviBarHeight()
      collectView.frame = CGRect(x: -(window.frame.width / 3),
                                 y: collYPossion,
                                 width: window.frame.width / 3,
                                 height: window.frame.height - collYPossion - 10)
      window.addSubview(collectView)
      
      UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
        self.backView.alpha = 1
        self.collectView.frame = CGRect(x: 0,
                                        y: collYPossion,
                                        width: window.frame.width / 3,
                                        height: window.frame.height - collYPossion)
      }, completion: nil)
      
    }
  }
  
  @IBAction func handleDismiss(setting: Setting) {
    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
      self.backView.alpha = 0
      
      if let window = UIApplication.shared.keyWindow {
        let collYPossion = self.statusBarHeight() + self.naviBarHeight()
        self.collectView.frame = CGRect(x: -(window.frame.width / 3),
                                   y: collYPossion,
                                   width: window.frame.width / 3,
                                   height: window.frame.height - collYPossion)
      }
    }) { (completed: Bool) in
//      if setting.labelName != "" {
//        self.homeVC?.showControllerForSetting(setting: setting)
//      }
    }
  }
  
//--- Data source delegate begin ---
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return settings.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingCell
    
    let setting = settings[indexPath.item]
    cell.setting = setting
    return cell
  }
//--- Data source delegate end ---

//--- View delegate begin ---
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let setting = self.settings[indexPath.item]
    handleDismiss(setting: setting)
  }
//--- View delegate end ---
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectView.frame.width, height: cellHeight)
  }
  
//--- Other function begin ---
  func statusBarHeight() -> CGFloat {
    let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
    return statusBarHeight
  }
  
  func naviBarHeight() -> CGFloat {
    let naviBarHeight = (UIApplication.shared.keyWindow?.rootViewController as! UINavigationController).navigationBar.frame.height
    return naviBarHeight
  }
//--- Other function end ---
}
