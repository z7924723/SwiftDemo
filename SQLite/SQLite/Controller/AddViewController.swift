//
//  InsertDbVC.swift
//  SQLite
//
//  Created by PinguMac on 2017/12/30.
//  Copyright © 2017年 PinguMac. All rights reserved.
//

import UIKit
import SQLite3

class AddViewController: UIViewController {

  var db: Sqlite?
  var dbTableName: String!
  var nameText: UITextField!
  var heightText: UITextField!
  var insertBtn: UIButton!
  var insertChk: UILabel!

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
    self.view.addSubview(heightText)
    
    // Insert Button
    insertBtn = UIButton(frame: CGRect(x: heightText.frame.minX,
                                       y: heightText.frame.maxY + 10,
                                       width: ScreenSize.width / 5,
                                       height: 30))
    insertBtn.setTitle("Insert", for: .normal)
    insertBtn.backgroundColor = UIColor.blue
    insertBtn.addTarget(nil,
                        action: #selector(AddViewController.insertBtnAction),
                        for: .touchDown)
    self.view.addSubview(insertBtn)
    
    // Data check label
    insertChk = UILabel(frame: CGRect(x: insertBtn.frame.maxX + 10,
                                      y: insertBtn.frame.minY,
                                      width: ScreenSize.width / 9,
                                      height: 30))
    self.view.addSubview(insertChk)
}

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func insertBtnAction() {
    guard (nameText.text != "") || (heightText.text != "") else {
      insertChk.text = "Error!"
      insertChk.textColor = UIColor.red
      return
    }
    
    if db != nil {
      let dbStatus = db!.insert("'\(dbTableName!)'",
                                rowInfo: ["name":"'\(nameText.text!)'",
                                          "height":"'\(heightText.text!)'"])
      if dbStatus == SQLITE_OK {
        self.navigationController!.popToRootViewController(animated: true)
      } else {
        insertChk.text = "Error!"
        insertChk.textColor = UIColor.red
      }
    }
  }
}
