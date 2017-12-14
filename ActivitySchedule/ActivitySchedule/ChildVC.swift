//
//  ChildVC.swift
//  ActivitySchedule
//
//  Created by PinguMac on 2017/12/13.
//  Copyright © 2017年 PinguMac. All rights reserved.
//

import UIKit

class ChildVC: UIViewController {
  
  var datePicker: UIDatePicker!
  var timePicker: UIDatePicker!
  var showDate: UILabel!
  var showTime: UILabel!
  var confirmBtn: UIButton!

  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    let fullScreenSize = UIScreen.main.bounds.size
    
    self.view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
    
    //---date label---
    let dateLab = UILabel(frame: CGRect(x: 100,
                                        y: fullScreenSize.height / 5,
                                        width: 50,
                                        height: 30))
    dateLab.text = "Date:"
    dateLab.adjustsFontSizeToFitWidth = true
    dateLab.font = UIFont(name: "Helvetica-Light", size: 20)
    dateLab.backgroundColor = UIColor.white
    self.view.addSubview(dateLab)
    
    //---show date label---
    showDate = UILabel(frame: CGRect(x: dateLab.frame.maxX + 10,
                                     y: fullScreenSize.height / 5,
                                     width: fullScreenSize.width / 3,
                                     height: 30))
    showDate.adjustsFontSizeToFitWidth = true
    showDate.font = UIFont(name: "Helvetica-Light", size: 20)
    showDate.backgroundColor = UIColor.white
    self.view.addSubview(showDate)

    //---time label---
    let timeLab = UILabel(frame: CGRect(x: 100,
                                        y: dateLab.frame.maxY + 10,
                                        width: 50,
                                        height: 30))
    timeLab.text = "Time:"
    timeLab.adjustsFontSizeToFitWidth = true
    timeLab.font = UIFont(name: "Helvetica-Light", size: 20)
    timeLab.backgroundColor = UIColor.white
    self.view.addSubview(timeLab)
    
    //---show time label---
    showTime = UILabel(frame: CGRect(x: timeLab.frame.maxX + 10,
                                     y: showDate.frame.maxY + 10,
                                     width: fullScreenSize.width / 3,
                                     height: 30))
    showTime.adjustsFontSizeToFitWidth = true
    showTime.font = UIFont(name: "Helvetica-Light", size: 20)
    showTime.backgroundColor = UIColor.white
    self.view.addSubview(showTime)
    
    //---UIDatePicker for date---
    datePicker = UIDatePicker(frame: CGRect(x: 0, y: showTime.frame.maxY + 150,
                                            width: fullScreenSize.width,
                                            height: 100))
    datePicker.datePickerMode = .date
    datePicker.backgroundColor = UIColor.white.withAlphaComponent(0.3)
    datePicker.date = Date() // set default date is today
    
    let dateFormat = DateFormatter()
    dateFormat.dateFormat = "yyyy-MM-dd"
    
    let fromDate = dateFormat.date(from: "2017-01-01")
    datePicker.minimumDate = fromDate

    let endDate = dateFormat.date(from: "2018-12-31")
    datePicker.maximumDate = endDate

    datePicker.locale = Locale(identifier: "zh_TW") // set date picker language
    
//    datePicker.addTarget(self,
//                         action: #selector(ChildVC.datePickerAction),
//                         for: .valueChanged)
    self.view.addSubview(datePicker)

    //---UIDatePicker for Time---
    timePicker = UIDatePicker(frame: CGRect(x: 0,
                                            y: datePicker.frame.maxY + 10,
                                            width: fullScreenSize.width,
                                            height: 100))
    timePicker.datePickerMode = .time
    timePicker.minuteInterval = 1
    timePicker.backgroundColor = UIColor.white.withAlphaComponent(0.3)
    timePicker.date = Date() // set default time is now
    
    let timeFormat = DateFormatter()
    timeFormat.dateFormat = "a HH:mm"

    let fromTime = timeFormat.date(from: "00:00")
    timePicker.minimumDate = fromTime

    let endTime = timeFormat.date(from: "11:59")
    timePicker.maximumDate = endTime
    
    timePicker.locale = Locale(identifier: "zh_TW") // set date picker language
    
//    timePicker.addTarget(self,
//                         action: #selector(ChildVC.timePickerAction),
//                         for: .valueChanged)
    self.view.addSubview(timePicker)
    
    //---confirm botton---
    confirmBtn = UIButton(frame: CGRect(x: fullScreenSize.width - 150,
                                        y: timePicker.frame.maxY,
                                        width: 100,
                                        height: 30))
    confirmBtn.setTitle("Confirm", for: .normal)
    confirmBtn.backgroundColor = UIColor.gray
    confirmBtn.addTarget(self,
                         action: #selector(ChildVC.confirmBtnAction(_:)),
                         for: .touchDown)
    self.view.addSubview(confirmBtn)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func datePickerAction(datePicker: UIDatePicker) {
    let dateFormat = DateFormatter()
    dateFormat.dateFormat = "yyyy-MM-dd"
    showDate.text = dateFormat.string(from: datePicker.date)
  }
  
  @IBAction func timePickerAction(datePicker: UIDatePicker) {
    let timeFormat = DateFormatter()
    timeFormat.dateFormat = "HH:mm"
    showTime.text = timeFormat.string(from: datePicker.date)
  }
  
  @IBAction func confirmBtnAction(_ sender: UIButton) {
    let dateFormat = DateFormatter()
    dateFormat.dateFormat = "yyyy-MM-dd"
    
    let timeFormat = DateFormatter()
    timeFormat.dateFormat = "HH:mm"
    
    let dateStr: String = dateFormat.string(from: datePicker.date)
    let timeStr: String = timeFormat.string(from: timePicker.date)
    
    let alertCtrl = UIAlertController(title: "Time Confirm",
                                      message: "\(dateStr) \(timeStr)",
                                      preferredStyle: .alert)
    
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    alertCtrl.addAction(cancelAction)
    
    let okAction = UIAlertAction(title: "Confirm",
                                 style: .default,
                                 handler: {
                                  (action: UIAlertAction!) -> Void in
                                  self.showDate.text = dateStr
                                  self.showTime.text = timeStr
                                 })
    alertCtrl.addAction(okAction)
    
    self.present(alertCtrl, animated: true, completion: nil)
  }
}
