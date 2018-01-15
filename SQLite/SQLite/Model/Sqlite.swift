//
//  Sqlite.swift
//  SQLite
//
//  Created by PinguMac on 2017/12/28.
//  Copyright © 2017年 PinguMac. All rights reserved.
//

import Foundation
import SQLite3

class Sqlite {
  
  var dbPtr: OpaquePointer? = nil
  let sqlitePath: String
  let rowCount = 15
  
  init?(path: String) {
    sqlitePath = path
    dbPtr = self.openDatabase(path: sqlitePath)
  }
  
  //Open database
  func openDatabase(path: String) -> OpaquePointer {
    var connectdb: OpaquePointer? = nil
    var dbStatus: Int32 = SQLITE_ERROR
    
    dbStatus = sqlite3_open(path, &connectdb)
    if dbStatus != SQLITE_OK {
      print("Unable to open database. Error code:", dbStatus)
    }
    return connectdb!
  }
  
  // Create Table
  func createTable(_ tableName: String, columnsInfo: [String]) -> Int32 {
    var dbStatus: Int32 = SQLITE_ERROR
    
    let sqlCmd: String = "create table if not exists \(tableName) "
                         + "(\(columnsInfo.joined(separator: ",")))"
//    print(sqlCmd)
    dbStatus = sqlite3_exec(self.dbPtr, String(sqlCmd), nil, nil, nil)
    if dbStatus == SQLITE_OK {
      print("Create table success.")
    }
    return dbStatus
  }
  
  // Insert data
  func insert(_ tableName: String, rowInfo: [String: String]) -> Int32 {
//    var statement: OpaquePointer? = nil
    var dbStatus: Int32 = SQLITE_ERROR
    
    let sqlCmd: String = "insert into \(tableName) "
                         + "(\(rowInfo.keys.joined(separator: ","))) "
                         + "values (\(rowInfo.values.joined(separator: ",")))"
//    dbStatus = sqlite3_prepare_v2(self.dbPtr, String(sqlCmd), -1, &statement, nil)
    dbStatus = sqlite3_exec(self.dbPtr, String(sqlCmd), nil, nil, nil)
    if dbStatus == SQLITE_OK {
//      if sqlite3_step(statement) == SQLITE_DONE {
        print("Insert data success.")
        return dbStatus
//      }
//      sqlite3_finalize(statement)
    }
    return dbStatus
  }
  
  // Fetch data
  func fetch(_ tableName: String, cond: String?, sortBy order: String?, offset: Int?) -> OpaquePointer {
    var statement: OpaquePointer? = nil
    var dbStatus: Int32 = SQLITE_ERROR
    
    var sqlCmd: String = "select * from \(tableName)"
    if let condition = cond {
      sqlCmd += " where \(condition)"
    }
    
    if let orderBy = order {
      sqlCmd += " order by \(orderBy)"
    }
    
    sqlCmd += " limit \(rowCount)"
    
    if let offsetNum = offset {
      sqlCmd += " OFFSET \(offsetNum)"
    }
    
    print("fetch:", sqlCmd)
    dbStatus = sqlite3_prepare_v2(self.dbPtr, String(sqlCmd), -1, &statement, nil)
    print("Fatch data status:", dbStatus)
    return statement!
  }
  
  // update data
  func update(_ tableName: String, cond: String?, rowInfo: [String: String]) -> Int32 {
    var statement: OpaquePointer? = nil
    var dbStatus: Int32 = SQLITE_ERROR
    
    var sqlCmd: String = "update \(tableName) set "
    
    // row info
    var info: [String] = []
    for (key, value) in rowInfo {
      info.append("\(key) = \(value)")
    }
    sqlCmd += info.joined(separator: ",")
    
    // condition
    if let condition = cond {
      sqlCmd += " where \(condition)"
    }
//    print(sqlCmd)
    
    dbStatus = sqlite3_prepare_v2(self.dbPtr, String(sqlCmd), -1, &statement, nil)
    if dbStatus == SQLITE_OK && sqlite3_step(statement) == SQLITE_DONE {
      print("Updata data success.")
      return dbStatus
    }
    sqlite3_finalize(statement)
    return dbStatus
  }

  // delete data
  func delete(_ tableName: String, cond: String?) -> Int32 {
    var statement: OpaquePointer? = nil
    var dbStatus: Int32 = SQLITE_ERROR
    
    var sqlCmd: String = "delete from \(tableName)"
    
    // condition
    if let condition = cond {
      sqlCmd += " where \(condition)"
    }
//    print(sqlCmd)
    dbStatus = sqlite3_prepare_v2(self.dbPtr, String(sqlCmd), -1, &statement, nil)
    if dbStatus == SQLITE_OK && sqlite3_step(statement) == SQLITE_DONE {
      print("Delete data success.")
      return dbStatus
    }
    sqlite3_finalize(statement)
    return dbStatus
  }
  
  // count
  func dataAmount(_ tableName: String) {
    var statement: OpaquePointer? = nil
    var dbStatus: Int32 = SQLITE_ERROR
    var count: Int32 = 0
    
    let sqlCmd: String = "select count(*) from \(tableName)"
//    print(sqlCmd)
    dbStatus = sqlite3_prepare_v2(self.dbPtr, String(sqlCmd), -1, &statement, nil)
    if (dbStatus == SQLITE_OK) {
      if (sqlite3_step(statement) == SQLITE_ROW) {
        count = sqlite3_column_int(statement, 0);
        print("Data count:", count)
      }
      sqlite3_finalize(statement);
    }
  }
}
