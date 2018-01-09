//
//  SettingCell.swift
//  SideMenu
//
//  Created by PinguMac on 2018/1/3.
//  Copyright © 2018年 PinguMac. All rights reserved.
//

import UIKit

class SettingCell: UICollectionViewCell {
  
  var setting: Setting? {
    didSet {
      nameLabel.text = setting?.labelName
      
      if let imageName = setting?.imageName {
        iconImageView.image = UIImage(named: imageName)
      }
    }
  }
  
  let iconImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.image = UIImage(named: "setting")
    imageView.sizeToFit()
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  let nameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Setting"
    label.sizeToFit()
    label.font = UIFont.boldSystemFont(ofSize: 13)
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)

    self.addSubview(iconImageView)
    let imgTop = iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor)
    let imgLeft = iconImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor)
    let imgBottom = iconImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    let imgwidth = iconImageView.widthAnchor.constraint(equalToConstant: 24)
    let newImgCons: [NSLayoutConstraint] = [imgTop, imgLeft, imgBottom, imgwidth]
    NSLayoutConstraint.activate(newImgCons)
    
    self.addSubview(nameLabel)
    let labelTop = nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor)
    let labelLeft = nameLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor)
    let labelBottom = nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    let labelRight = nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor)
    let newlabelCons: [NSLayoutConstraint] = [labelTop, labelLeft, labelBottom, labelRight]
    NSLayoutConstraint.activate(newlabelCons)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
