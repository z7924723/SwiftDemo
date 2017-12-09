//
//  ViewController.swift
//  SeekBarPercentage
//
//  Created by PinguMac on 2017/11/22.
//  Copyright © 2017年 PinguMac. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
  var DiscountVal          : Int = 0
  var UserInputVal         : Int = 0
  var DiscountPercentageVal: Int = 0
  var PercentageVal        : Int = 0
  var DiscountMoneyVal     : Int = 0
  
  @IBOutlet weak var DiscountPercentageLabel: UILabel!
  @IBOutlet weak var DiscountMoneyLabel     : UILabel!
  @IBOutlet weak var AfterPriceLabel        : UILabel!
  @IBOutlet weak var UserInputText          : UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    UserInputText.delegate = self
    
    // Initial label value
    DiscountPercentageLabel.text = "(\(DiscountVal))"
    DiscountMoneyLabel.text = String("$0.0")
    AfterPriceLabel.text = String("$0.0")
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
//    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView))
//    view.addGestureRecognizer(tapGesture)
  }
  
  @objc func didTapView() {
    print(view)
    UserInputText.resignFirstResponder()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  // Put the keyboard closed when touch blank space
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    print("touch begin")
    self.view.endEditing(true)
  }
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    // Create an `NSCharacterSet` set which includes everything *but* the digits
    let inverseSet = NSCharacterSet(charactersIn:"0123456789").inverted

    // At every character in this "inverseSet" contained in the string,
    // split the string up into components which exclude the characters
    // in this inverse set
    let components = string.components(separatedBy: inverseSet)

    // Rejoin these components
    let filtered = components.joined(separator: "")  // use join("", components) if you are using Swift 1.2

    // If the original string is equal to the filtered string, i.e. if no
    // inverse characters were present to be eliminated, the input is valid
    // and the statement returns true; else it returns false
    return string == filtered
  }
  
  @IBAction func UpdateDataBySlider(_ sender: UISlider) {
    if let number = Int(UserInputText.text!) {
      UserInputVal = number
    } else {
      UserInputVal = 0
    }
    
    
    DiscountVal      = lroundf(sender.value)
    DiscountMoneyVal = (UserInputVal * DiscountVal) / 100

    DiscountPercentageLabel.text = "(\(DiscountVal)%)"
    DiscountMoneyLabel.text = "$" + String(DiscountMoneyVal)
    AfterPriceLabel.text = "$" + String(UserInputVal - DiscountMoneyVal)
  }
}

