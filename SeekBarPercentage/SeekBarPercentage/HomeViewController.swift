//
//  HomeViewController.swift
//  SeekBarPercentage
//
//  Created by PinguMac on 2017/11/23.
//  Copyright © 2017年 PinguMac. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
  
  @IBOutlet weak var textField: UITextField!
  
  override func viewDidLoad() {
      super.viewDidLoad()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView))
    view.addGestureRecognizer(tapGesture)
  }
  
  @objc func didTapView() {
    print(view)
    textField.resignFirstResponder()
  }


}

extension HomeViewController: UITableViewDelegate {
 
}
