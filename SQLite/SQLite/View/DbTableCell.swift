//
//  DbTableCell.swift
//  SQLite
//
//  Created by PinguMac on 2018/1/1.
//  Copyright © 2018年 PinguMac. All rights reserved.
//

import UIKit

class DbTableCell: UITableViewCell {
    
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: .value2, reuseIdentifier: reuseIdentifier)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
