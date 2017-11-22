//
//  ViewController.swift
//  Implementation1
//
//  Created by PinguMac on 2017/11/21.
//  Copyright © 2017年 PinguMac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  var Round: Int = 0
  @IBOutlet weak var RoundLabel:UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func UpdateRoundNum() {
    Round += 1
    RoundLabel.text = String(Round)
  }

  @IBAction func ClearRound(_ sender: Any) {
    Round = 0
    RoundLabel.text = String(Round)
  }
}

