//
//  HomeViewController.swift
//  SQLite
//
//  Created by PinguMac on 2018/1/8.
//  Copyright © 2018年 PinguMac. All rights reserved.
//

import UIKit
import SQLite3

class HomeViewController: UIViewController {

  let dbTableName: String = "UserInfoTable"
  var db: Sqlite?
  var dbData: [UserInfo] = [UserInfo]()
  var dbTableView: UITableView = UITableView()
  var limitCondtion: Int = 1
  var lastId = 0
  var noData = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    let ScreenSize = UIScreen.main.bounds.size
    self.view.backgroundColor = UIColor.white
    
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                             target: self,
                                                             action: #selector(HomeViewController.addData))
    
    let destinationUrl = getDirectoryPath().appendingPathComponent("sqlite3.db")
    db = Sqlite(path: destinationUrl.absoluteString)
    if db != nil {
      let dbStatus = db!.createTable(dbTableName,
                                     columnsInfo: ["id integer primary key autoincrement",
                                                   "name text",
                                                   "height double"])
      if dbStatus == SQLITE_OK {
        dbTableView = UITableView(frame: CGRect(x: 0,
                                                y: 0,
                                                width: ScreenSize.width,
                                                height: ScreenSize.height),
                                      style: .plain)
        dbTableView.register(DbTableCell.self, forCellReuseIdentifier: "Cell")
        dbTableView.delegate = self
        dbTableView.dataSource = self
        dbTableView.separatorStyle = .singleLine
//        dbTableView.bounces = false // will not spring back
//        dbTableView.contentInset = UIEdgeInsets(top: -34, left: 0, bottom: -34, right: 0)
        self.view.addSubview(dbTableView)
        
//        dbData = fetchData(offset: 1)!
      }
    }
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
//    dbData = fetchData(offset: 0)!
    fetchData(offset: 0)
    dbTableView.reloadData()
    db?.dataAmount(dbTableName)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(true)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
    
  func getDirectoryPath() -> URL {
    // create document folder url
    let fileDirectoryURL = FileManager.default.urls(for: .documentDirectory,
                                                    in: .userDomainMask).first!
    return fileDirectoryURL
  }
  
//  func fetchData(offset: Int) -> [UserInfo]? {
  func fetchData(offset: Int) {
    let statement = db!.fetch("UserInfoTable", cond: nil, sortBy: nil, offset: offset)
    var fetchResult: [UserInfo] = [UserInfo]()
    
    while sqlite3_step(statement) == SQLITE_ROW {
      let id = sqlite3_column_int(statement, 0)
      let name = String(cString: sqlite3_column_text(statement, 1))
      let height = sqlite3_column_double(statement, 2)
      
      fetchResult.append(UserInfo.init(id: id, name: name, height: height))
    }
    
    if (offset != 0) && (fetchResult.count < 15) {
      noData = true
    }
//    dbData.append(contentsOf: fetchResult)
    dbData = fetchResult
//    lastId = fetchResult.count
    lastId = dbData.count
    print("lastId:", lastId)
//    return fetchResult
  }
  
  @IBAction func addData() {
    let addDataVC = AddViewController()
    addDataVC.dbTableName = dbTableName
    addDataVC.db = self.db
    self.navigationController?.pushViewController(addDataVC, animated: true)
  }
}

extension HomeViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let updateVC = UpdateViewController()
    updateVC.db = self.db
    updateVC.dbTableName = dbTableName
    updateVC.dbRowId = dbData[indexPath.row].id
    updateVC.nameInfo = dbData[indexPath.row].name
    updateVC.heightInfo = dbData[indexPath.row].height
    self.navigationController?.pushViewController(updateVC, animated: true)
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//    if ((indexPath.row + 1) % 15 == 0) && (indexPath.row >= 14) && (indexPath.row + 1  == dbData.count) {
//      let limitTimes: Int = (indexPath.row + 1) / 15
//      limitCondtion += limitTimes
//      print("limitCondtion:", limitCondtion)
//      dbData = fetchData(offset: limitCondtion)!
//      print(dbData.count)
//      dbTableView.reloadData()
//    }
//    print(indexPath.row)
    if (indexPath.row + 1 == dbData.count - 3) && !noData {
      fetchData(offset: 15)
      dbTableView.reloadData()
    }
  }
}

extension HomeViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dbData.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! DbTableCell
    cell.textLabel?.text = String(dbData[indexPath.row].name)
    cell.detailTextLabel?.text = String(dbData[indexPath.row].height)
    return cell
  }
    
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      _ = db!.delete(dbTableName, cond: "id = \(dbData[indexPath.row].id)")
      dbData.remove(at: indexPath.row)
      dbTableView.deleteRows(at: [indexPath], with: .fade)

//      dbData = fetchData(offset: 0)!
      fetchData(offset: 0)
      dbTableView.reloadData()
    }
  }
}

extension HomeViewController: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
//    print(scrollView.contentOffset.y)
  }
  func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    if velocity.y > 0 {
//      print("up.")
    } else {
//      print("down.")
    }
  }
}
