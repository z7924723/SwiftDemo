//
//  TableViewCell.swift
//  ImageList
//
//  Created by PinguMac on 2017/12/15.
//  Copyright © 2017年 PinguMac. All rights reserved.
//

import UIKit

class TableCellContent: UITableViewCell {

  var imgView: UIImageView!
  var strLabel: UILabel!
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    
    let screenSize = UIScreen.main.bounds.size
    
    imgView = UIImageView(frame: CGRect(x: 0,
                                        y: 0,
                                        width: screenSize.width,
                                        height: screenSize.width/3))
    self.addSubview(imgView)

    
    strLabel = UILabel(frame:CGRect(x: 0,
                                    y: imgView.frame.maxY,
                                    width: screenSize.width,
                                    height: 40))
    self.addSubview(strLabel)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
