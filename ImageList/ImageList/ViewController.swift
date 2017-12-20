//
//  ViewController.swift
//  ImageList
//
//  Created by PinguMac on 2017/12/15.
//  Copyright © 2017年 PinguMac. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
  
  var imgList: [UIImage] = [
    UIImage(named: "01.jpg")!,
    UIImage(named: "02.jpg")!,
    UIImage(named: "03.jpg")!,
    UIImage(named: "04.jpg")!,
    UIImage(named: "05.jpg")!
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    let fullScreen = UIScreen.main.bounds.size
    self.view.backgroundColor = UIColor.white

    // creat UITableView
    let tableView = UITableView(frame: CGRect(x: 0,
                                              y: 20,
                                              width: fullScreen.width,
                                              height: fullScreen.height - 20),
                                style: .plain)
    
    tableView.register(TableCellContent.self, forCellReuseIdentifier: "Cell")
    
    tableView.rowHeight = fullScreen.width / 3 + 40
    // separator line style
    tableView.separatorStyle = .singleLine
    tableView.separatorInset = UIEdgeInsetsMake(0, 20, 0, 20)
    tableView.allowsSelection = true
    tableView.allowsMultipleSelection = false
    
    tableView.dataSource = self
    
    self.view.addSubview(tableView)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return imgList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableCellContent

//    cell.textLabel?.text = "bbb"
//    cell.detailTextLabel?.text = "aaa"
//    cell.imageView?.image = imgList[indexPath.row]
    cell.imgView.image = imgList[indexPath.row]
    cell.strLabel.text = "aaa"
    return cell
  }
}

