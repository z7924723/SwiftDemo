//
//  ViewController.swift
//  LocalNotification
//
//  Created by PinguMac on 2018/1/4.
//  Copyright © 2018年 PinguMac. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
  
  let notifyInSecond = 10
  let repeatNotify: Bool = false
  let notificationId = "constomNotification"
  
  let notifyBtn: UIButton = {
    let botton = UIButton(frame: CGRect(x: 100, y: 100, width: 80, height: 50))
    botton.setTitle("Notify", for: .normal)
    botton.backgroundColor = UIColor.blue
    return botton
  }()
  
  let cancelBtn: UIButton = {
    let botton = UIButton(frame: CGRect(x: 200, y: 100, width: 80, height: 50))
    botton.setTitle("Cancel", for: .normal)
    botton.backgroundColor = UIColor.blue
    botton.addTarget(self,
                     action: #selector(ViewController.cancelPress),
                     for: .touchUpInside)
    return botton
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
        
    notifyBtn.addTarget(self,
                        action: #selector(ViewController.notifyPress),
                        for: .touchUpInside)
    self.view.addSubview(notifyBtn)
    self.view.addSubview(cancelBtn)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func notifyPress() {
    timeNotification(inSeconds: TimeInterval(notifyInSecond)) { (success) in
      if success {
        print("Success Notify.")
      }
    }
  }
  
  func timeNotification(inSeconds: TimeInterval, completion: @escaping (_ success: Bool) -> ()) {
    let content = UNMutableNotificationContent()
    guard let imgURL = Bundle.main.url(forResource: "NickYoung", withExtension: "gif") else {
      completion(false)
      return
    }
  
    let attachment = try! UNNotificationAttachment(identifier: "NickYoung", url: imgURL, options: .none)
    content.title = "New notification"
    content.subtitle = "Hello!"
    content.body = "Content body."
    content.attachments = [attachment]
    content.sound = UNNotificationSound.default()
    content.badge = (UIApplication.shared.applicationIconBadgeNumber + 1) as NSNumber
    
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: repeatNotify)
    
    let request = UNNotificationRequest(identifier: notificationId,
                                        content: content,
                                        trigger: trigger)
    
    UNUserNotificationCenter.current().add(request) { (error) in
      if error == nil {
        completion(true)
      } else {
        completion(false)
      }
    }
  }
  
  @IBAction func cancelPress() {
    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    print("cancelPress")
  }
}

