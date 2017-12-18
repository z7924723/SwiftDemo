//
//  CellContent.swift
//  GithubStars
//
//  Created by PinguMac on 2017/12/7.
//  Copyright © 2017年 PinguMac. All rights reserved.
//

import UIKit

class CellContent: UITableViewCell {
  
  var nameLabel: UILabel!
  var descLabel: UILabel!
  var forksCount: UILabel!
  var login: UILabel!
  var stargazers: UILabel!
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    let ScreenWidth = UIScreen.main.bounds.size.width
    
    nameLabel = UILabel(frame:CGRect(x: ScreenWidth / 3,
                                     y: 0,
                                     width: ScreenWidth / 3,
                                     height: 40))
    self.addSubview(nameLabel)
    
    descLabel = UILabel(frame:CGRect(x: ScreenWidth / 3,
                                     y: nameLabel.frame.maxY,
                                     width: ScreenWidth,
                                     height: 40))
    self.addSubview(descLabel)
    
    stargazers = UILabel(frame:CGRect(x: 0,
                                      y: descLabel.frame.maxY + 100,
                                      width: ScreenWidth / 5,
                                      height: 40))
    self.addSubview(stargazers)
    
    forksCount = UILabel(frame:CGRect(x: stargazers.frame.maxX + 50,
                                      y: descLabel.frame.maxY + 100,
                                      width: ScreenWidth / 5,
                                      height: 40))
    self.addSubview(forksCount)
    
    login = UILabel(frame:CGRect(x: forksCount.frame.maxX + 50,
                                 y: descLabel.frame.maxY + 100,
                                 width: ScreenWidth / 4,
                                 height: 40))
    self.addSubview(login)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
