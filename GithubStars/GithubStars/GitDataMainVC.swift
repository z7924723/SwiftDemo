//
//  GitDataMainVC.swift
//  GithubStars
//
//  Created by PinguMac on 2017/12/8.
//  Copyright © 2017年 PinguMac. All rights reserved.
//

import UIKit

class GitDataMainVC: UIViewController, UITextFieldDelegate {

  var myTextField: UITextField = UITextField()
  
  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    let ScreenWidth = UIScreen.main.bounds.size.width
    
    self.title = "GitHubStars"
    self.navigationController?.navigationBar.barTintColor = UIColor.blue
    self.navigationController?.navigationBar.isTranslucent = false

    // search text field
    myTextField = UITextField(frame: CGRect(x: ScreenWidth / 3 - 25,
                                            y: ScreenWidth / 2,
                                            width: 200,
                                            height: 50))
    myTextField.placeholder = "Input Github ID"
    myTextField.font = UIFont.boldSystemFont(ofSize: 20)
    myTextField.clearButtonMode = .whileEditing
    myTextField.returnKeyType = .done
    myTextField.textColor = UIColor.white
    myTextField.backgroundColor = UIColor.lightGray
    myTextField.autocapitalizationType = .none // lower case for first letter
    
    myTextField.delegate = self
    self.view.addSubview(myTextField)
    
    // Search button
    let searchBtn: UIButton = UIButton()
    searchBtn.frame = CGRect(x: ScreenWidth / 3,
                             y: myTextField.frame.maxY + 10,
                             width: 150,
                             height: 50)
    searchBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    searchBtn.titleLabel?.adjustsFontSizeToFitWidth = true
    searchBtn.setTitle("Search", for: .normal)
    searchBtn.setTitleColor(UIColor.white, for: .normal)
    searchBtn.layer.cornerRadius = 10
    searchBtn.backgroundColor = UIColor.blue
    searchBtn.addTarget(self,
                        action: #selector(GitDataMainVC.searchBtnAction(_:)),
                        for: UIControlEvents.touchUpInside)
    self.view.addSubview(searchBtn)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    //Hide keyboard when press return or done
    self.view.endEditing(true)
    
    return true
  }
  
  @IBAction func searchBtnAction(_ sender: Any) {
    let newVc = ShowDataVC()
    newVc.gitHubID = myTextField.text!
    self.navigationController?.pushViewController(newVc, animated: true)
  }
}
