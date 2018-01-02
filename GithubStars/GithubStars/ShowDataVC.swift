//
//  ViewController.swift
//  GithubStars
//
//  Created by PinguMac on 2017/12/4.
//  Copyright © 2017年 PinguMac. All rights reserved.
//

import UIKit

struct Owner: Codable {
  let login      : String
  let id         : Int
  let avatar_url : URL
  let type       : String
  let site_admin : Bool
}

struct starInfo: Codable {
  let id              : Int
  let name            : String
  let full_name       : String
  let owner           : Owner
  let description     : String?
  let forks           : Int
  let stargazers_count: Int
}

class ShowDataVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  var dataCount: Int = 0
  var cellData: [starInfo] = [starInfo]()
  var myTableView: UITableView = UITableView()
  var gitHubID: String = ""
  var getError: Bool = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  
    let fullScreenSize = UIScreen.main.bounds.size
    
    self.navigationController?.navigationBar.barTintColor = UIColor.cyan

    // Create UITable view
    myTableView = UITableView(frame: CGRect(x: 0,
                                            y: 0,
                                            width: fullScreenSize.width,
                                            height: fullScreenSize.height),
                              style: .grouped)
    
    myTableView.register(CellContent.self, forCellReuseIdentifier: "Cell")
    myTableView.delegate = self
    myTableView.dataSource = self
    myTableView.allowsSelection = false
    myTableView.separatorStyle = .singleLine
    
    print("gitHubID:", gitHubID)
    getData("https://api.github.com/users/\(gitHubID)/starred")
    
    self.view.addSubview(myTableView)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    print("cellData.count: ", cellData.count)
    return cellData.count
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    // Height for each row
    return 240
  }
  
  // show cell contents
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CellContent
    
//    guard getError == true else {
//      cell.nameLabel.text = "Error!!!!!"
//      return cell
//    }
    
    cell.nameLabel.text = cellData[indexPath.row].name
    cell.descLabel.text = cellData[indexPath.row].description
    cell.stargazers.text = String(cellData[indexPath.row].stargazers_count)
    cell.forksCount.text = String(cellData[indexPath.row].forks)
    cell.login.text = cellData[indexPath.row].owner.login
    
    return cell
  }
  
  func getData(_ link: String) {
    let url: URL = URL(string: link)!
    let session = URLSession.shared
    let request = URLRequest(url: url)
    
    let task = session.dataTask(with: request, completionHandler: {
      (data, response, error) in
      
      self.extractData(data)
    })
    task.resume()
  }
  
  func extractData(_ data: Data?) {
    if(data == nil) {
      print("No data, data is nil")
      return
    }
    
    do {
      cellData = try JSONDecoder().decode([starInfo].self, from: data!)
    } catch {
      getError = true
      print("Error:", error.localizedDescription)
    }
    
//    for index in cellData {
//      print("\(cellData.description)\n")
//    }
    refreshTable()
  }
  
  func refreshTable() {
    DispatchQueue.main.async(
      execute:
      {
        self.myTableView.reloadData()
    })
  }
}
