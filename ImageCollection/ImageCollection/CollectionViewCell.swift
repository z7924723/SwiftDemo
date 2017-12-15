//
//  CollectionViewCell.swift
//  ImageCollection
//
//  Created by PinguMac on 2017/12/14.
//  Copyright © 2017年 PinguMac. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
  
  var imgView: UIImageView!
  var titleLabel: UILabel!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    let width = Double(UIScreen.main.bounds.size.width)
    
    // 建立一個 UIImageView
    imgView = UIImageView(frame: CGRect(x: 0,
                                        y: 0,
                                        width: width/3 - 10.0,
                                        height: width/3 - 10.0))
    self.addSubview(imgView)
    
    // 建立一個 UILabel
    titleLabel = UILabel(frame: CGRect(x: 0,
                                       y: Int(imgView.frame.maxY),
                                       width: Int(width / 3 - 10),
                                       height: 40))
    titleLabel.textAlignment = .center
    titleLabel.textColor = UIColor.orange
    self.addSubview(titleLabel)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
