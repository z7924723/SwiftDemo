//
//  ViewController.swift
//  UserDefaults
//
//  Created by PinguMac on 2017/12/18.
//  Copyright © 2017年 PinguMac. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

  let fullSize = UIScreen.main.bounds.size

  var textField: UITextField!
  var userDefaults: UserDefaults!
  var updateBtn: UIButton!
  var deleteBtn: UIButton!

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = UIColor.white

    userDefaults = UserDefaults.standard //Returns the shared defaults object.
    
    self.title = "首頁"
    self.navigationController?.navigationBar.isTranslucent = true
    let rightButton = UIBarButtonItem(title: "顯示",
                                      style: .plain,
                                      target: self,
                                      action: #selector(ViewController.display))
    self.navigationItem.rightBarButtonItem = rightButton
    
    // create text field to input data
    textField = UITextField(frame: CGRect(x: 0,
                                          y: 0,
                                          width: fullSize.width * 0.95,
                                          height: 40))
    textField.placeholder = "Please input name."
    textField.clearButtonMode = .whileEditing
    textField.returnKeyType = .done
    textField.textColor = UIColor.white
    textField.backgroundColor = UIColor.lightGray
    textField.delegate = self
    textField.center = CGPoint(x: fullSize.width * 0.5,
                               y: fullSize.height * 0.2)
    self.view.addSubview(textField)
    
    // Update button
    updateBtn = UIButton(frame: CGRect(x: fullSize.width / 6,
                                       y: textField.frame.maxY + 20,
                                       width: 120,
                                       height: 40))
    updateBtn.setTitle("Update", for: .normal)
    updateBtn.backgroundColor = UIColor.blue
    updateBtn.addTarget(self,
                        action: #selector(ViewController.updateInfo),
                        for: .touchUpInside)
    self.view.addSubview(updateBtn)
    
    // Delete button
    deleteBtn = UIButton(frame: CGRect(x: updateBtn.frame.maxX + 30,
                                       y: textField.frame.maxY + 20,
                                       width: 120,
                                       height: 40))
    deleteBtn.setTitle("Delete", for: .normal)
    deleteBtn.backgroundColor = UIColor.blue
    deleteBtn.addTarget(self,
                        action: #selector(ViewController.removeInfo),
                        for: .touchUpInside)
    self.view.addSubview(deleteBtn)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func display() {
    self.navigationController!.pushViewController(DisplayVC(), animated: true)
  }
  
  @IBAction func updateInfo() {
    self.view.endEditing(true) // Hide keyboard
    userDefaults.set(textField.text, forKey: "name")
    textField.text = ""
  }
  
  @IBAction func removeInfo() {
    userDefaults.removeObject(forKey: "name")
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    self.updateInfo()
    return true
  }
}

