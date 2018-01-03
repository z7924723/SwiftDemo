//
//  ViewController.swift
//  ProgramConstraints
//
//  Created by PinguMac on 2018/1/2.
//  Copyright © 2018年 PinguMac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  let pressBotton: UIButton = {
    let botton = UIButton()
    botton.translatesAutoresizingMaskIntoConstraints = false
    botton.backgroundColor = UIColor.orange
    botton.setTitle("Press", for: .normal)
    botton.setTitleColor(UIColor.white, for: .normal)
    botton.addTarget(self, action: #selector(ViewController.action), for: .touchUpInside)
    return botton
  }()
  
  var buttonCons: [NSLayoutConstraint] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.addSubview(pressBotton)
    setupLayout()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func action() {
    NSLayoutConstraint.deactivate(buttonCons)
    
    //Define new constraint
    let btnHeight = pressBotton.heightAnchor.constraint(equalToConstant: 200)
    let btnWidth = pressBotton.widthAnchor.constraint(equalToConstant: 200)
    let xPlacement = pressBotton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
    let yPlacement = pressBotton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
    
    let newBtnCons: [NSLayoutConstraint] = [btnHeight, btnWidth, xPlacement, yPlacement]
    NSLayoutConstraint.activate(newBtnCons)
  }
  
  func setupLayout() {
    //Constraints for button
    let topConstraint = pressBotton.topAnchor.constraint(equalTo: self.view.topAnchor)
    let bottomConstraint = pressBotton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
    let leftConstraint = pressBotton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
    let rightConstraint = pressBotton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
    buttonCons = [topConstraint, bottomConstraint, leftConstraint, rightConstraint]
    NSLayoutConstraint.activate(buttonCons)
  }
}
