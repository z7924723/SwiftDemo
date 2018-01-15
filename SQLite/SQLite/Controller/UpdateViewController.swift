//
//  UpdateViewController.swift
//  SQLite
//
//  Created by PinguMac on 2018/1/8.
//  Copyright © 2018年 PinguMac. All rights reserved.
//

import UIKit
import SQLite3

class UpdateViewController: UIViewController {
  
  var db: Sqlite?
  var dbTableName: String!
  var dbRowId: Int32!
  var nameInfo: String!
  var heightInfo: Double!
  var nameText: UITextField!
  var heightText: UITextField!
  var updateBtn: UIButton!
  var updateChk: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    let ScreenSize = UIScreen.main.bounds.size
    self.view.backgroundColor = UIColor.white
    
    // Name label
    let nameLab = UILabel(frame: CGRect(x: 0,
                                        y: 0,
                                        width: ScreenSize.width / 4,
                                        height: 30))
    nameLab.center = CGPoint(x: ScreenSize.width * 0.25, y: ScreenSize.height * 0.15)
    nameLab.text = "Name"
    nameLab.adjustsFontSizeToFitWidth = true
    nameLab.font = UIFont(name: "Helvetica-Light", size: 20)
    self.view.addSubview(nameLab)
    
    // Name text
    nameText = UITextField(frame: CGRect(x: nameLab.frame.maxX + 20,
                                         y: nameLab.frame.minY,
                                         width: ScreenSize.width / 4,
                                         height: 30))
    nameText.borderStyle = .roundedRect
    nameText.text = nameInfo
    self.view.addSubview(nameText)
    
    // Height label
    let heightLab = UILabel(frame: CGRect(x: nameLab.frame.minX,
                                          y: nameLab.frame.maxY + 10,
                                          width: ScreenSize.width / 4,
                                          height: 30))
    heightLab.text = "Height"
    heightLab.adjustsFontSizeToFitWidth = true
    heightLab.font = UIFont(name: "Helvetica-Light", size: 20)
    self.view.addSubview(heightLab)
    
    // Height text
    heightText = UITextField(frame: CGRect(x: heightLab.frame.maxX + 20,
                                           y: heightLab.frame.minY,
                                           width: ScreenSize.width / 4,
                                           height: 30))
    heightText.borderStyle = .roundedRect
    heightText.text = String(heightInfo)
    self.view.addSubview(heightText)
    
    // Insert Button
    updateBtn = UIButton(frame: CGRect(x: heightText.frame.minX,
                                       y: heightText.frame.maxY + 10,
                                       width: ScreenSize.width / 5,
                                       height: 30))
    updateBtn.setTitle("Update", for: .normal)
    updateBtn.backgroundColor = UIColor.blue
    updateBtn.addTarget(nil,
                        action: #selector(UpdateViewController.updateBtnAction),
                        for: .touchDown)
    self.view.addSubview(updateBtn)
    
    // Data check label
    updateChk = UILabel(frame: CGRect(x: updateBtn.frame.maxX + 10,
                                      y: updateBtn.frame.minY,
                                      width: ScreenSize.width / 9,
                                      height: 30))
    self.view.addSubview(updateChk)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func updateBtnAction() {
    if db != nil {
      let dbStatus = db?.update(dbTableName,
                                cond: "id = '\(dbRowId!)'",
                                rowInfo: ["name":"'\(nameText.text!)'",
                                          "height":"'\(heightText.text!)'"])
      if dbStatus == SQLITE_OK {
        self.navigationController!.popToRootViewController(animated: true)
      } else {
        updateChk.text = "Error!"
        updateChk.textColor = UIColor.red
      }
    }
  }
}
