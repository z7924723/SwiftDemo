//
//  UserInfo.swift
//  SQLite
//
//  Created by PinguMac on 2018/1/8.
//  Copyright © 2018年 PinguMac. All rights reserved.
//

import Foundation

enum Operate {
  case Insert
  case None
}

struct UserInfo {
  let id: Int32
  let name: String
  let height: Double
}
