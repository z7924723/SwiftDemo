//
//  PresentDataViewController.swift
//  QRCode
//
//  Created by PinguMac on 2018/5/17.
//  Copyright © 2018年 PinguMac. All rights reserved.
//

import UIKit

class PresentDataViewController: UIViewController {
  
  var qrCodeString: String!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    print(qrCodeString)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    if let qrCodeString = qrCodeString {
      let prefixString = qrCodeString.prefix(7)
      
      if prefixString == "AppCamp" {
        let filterString = qrCodeString.filter {
          "0123456789".contains($0)
        }
        print(filterString)
        topUpAlert(money: Int(filterString)!)
      }
    } else {
      print("QRCode error")
    }
  }
  
  private func topUpAlert(money: Int) {
    let alertController = UIAlertController(title: "儲值成功",
                                            message: "一共儲值\(money)個代幣",
                                            preferredStyle: .alert)
    
    let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
      print("press OK")
      self.performSegue(withIdentifier: "unWindToRootViewController", sender: self)
    }
    alertController.addAction(okAction)
    
    self.present(alertController, animated: true, completion: nil)
  }
  
}
