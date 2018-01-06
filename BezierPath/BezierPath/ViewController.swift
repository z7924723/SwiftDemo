//
//  ViewController.swift
//  BezierPath
//
//  Created by PinguMac on 2018/1/5.
//  Copyright © 2018年 PinguMac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  let startPoint = CGPoint(x: 50, y: 300)
  let endPoint = CGPoint(x: 300, y: 300)
  let controlPoint1 = CGPoint(x: 170, y: 200)
  let controlPoint2 = CGPoint(x: 200, y: 500)
  
  let path = UIBezierPath()
  let layer = CAShapeLayer()

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.

    path.move(to: startPoint)
    path.addCurve(to: endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
    
    layer.path = path.cgPath
    layer.fillColor = UIColor.clear.cgColor
    layer.strokeColor = UIColor.red.cgColor
    animation1()
//    animation2()
//    animation3()
    view.layer.addSublayer(layer)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  private func animation1() {
    let animation = CABasicAnimation(keyPath: "strokeEnd")
    animation.fromValue = 0
    animation.toValue = 1
    animation.repeatCount = 3 // repeat times
    animation.duration = 10  // seconds
    
    layer.add(animation, forKey: "")
  }
  
  private func animation2() {
    let animation = CABasicAnimation(keyPath: "strokeStart")
    animation.fromValue = 0.9
    animation.toValue = 0
    animation.repeatCount = 3
    animation.duration = 10
    
    let animation2 = CABasicAnimation(keyPath: "strokeEnd")
    animation2.fromValue = 0.9
    animation2.toValue = 1
    animation2.repeatCount = 3
    animation2.duration = 10
   
    layer.strokeStart = 0.5
    layer.strokeEnd = 0.5
    layer.add(animation, forKey: "")
    layer.add(animation2, forKey: "")
  }
  
  private func animation3() {
    let animation = CABasicAnimation(keyPath: "lineWidth")
    animation.fromValue = 0
    animation.toValue = 10
    animation.repeatCount = 3
    animation.duration = 10

    layer.add(animation, forKey: "")
  }
  
  func squareBezierCurve() {
    let layer1 = CALayer()
    layer1.frame = CGRect(x: startPoint.x, y: startPoint.y, width: 5, height: 5)
    layer1.backgroundColor = UIColor.red.cgColor
    
    let layer2 = CALayer()
    layer2.frame = CGRect(x: endPoint.x, y: endPoint.y, width: 5, height: 5)
    layer2.backgroundColor = UIColor.red.cgColor
    
    let layer3 = CALayer()
    layer3.frame = CGRect(x: controlPoint1.x, y: controlPoint1.y, width: 5, height: 5)
    layer3.backgroundColor = UIColor.red.cgColor
    
    let path = UIBezierPath()
    let layer = CAShapeLayer()
    
    path.move(to: startPoint)
    path.addQuadCurve(to: endPoint, controlPoint: controlPoint1)
    
    layer.path = path.cgPath
    layer.fillColor = UIColor.clear.cgColor
    layer.strokeColor = UIColor.black.cgColor
    
    view.layer.addSublayer(layer)
    view.layer.addSublayer(layer1)
    view.layer.addSublayer(layer2)
    view.layer.addSublayer(layer3)
  }

  func cubicBezierCurve() {
    let layer1 = CALayer()
    layer1.frame = CGRect(x: startPoint.x, y: startPoint.y, width: 5, height: 5)
    layer1.backgroundColor = UIColor.red.cgColor
    
    let layer2 = CALayer()
    layer2.frame = CGRect(x: endPoint.x, y: endPoint.y, width: 5, height: 5)
    layer2.backgroundColor = UIColor.red.cgColor
    
    let layer3 = CALayer()
    layer3.frame = CGRect(x: controlPoint1.x, y: controlPoint1.y, width: 5, height: 5)
    layer3.backgroundColor = UIColor.red.cgColor
    
    let layer4 = CALayer()
    layer4.frame = CGRect(x: controlPoint2.x, y: controlPoint2.y, width: 5, height: 5)
    layer4.backgroundColor = UIColor.red.cgColor
    
    let path = UIBezierPath()
    let layer = CAShapeLayer()
    
    path.move(to: startPoint)
    path.addCurve(to: endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
  
    layer.path = path.cgPath
    layer.fillColor = UIColor.clear.cgColor
    layer.strokeColor = UIColor.black.cgColor
    
    view.layer.addSublayer(layer)
    view.layer.addSublayer(layer1)
    view.layer.addSublayer(layer2)
    view.layer.addSublayer(layer3)
    view.layer.addSublayer(layer4)
  }
}

