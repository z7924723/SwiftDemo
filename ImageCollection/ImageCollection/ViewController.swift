//
//  ViewController.swift
//  ImageCollection
//
//  Created by PinguMac on 2017/12/14.
//  Copyright © 2017年 PinguMac. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
  
  var fullSize: CGSize!

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    fullSize = UIScreen.main.bounds.size
    self.view.backgroundColor = UIColor.white

    // Collection layout
    let layout = UICollectionViewFlowLayout()
    layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    layout.minimumLineSpacing = 10 // space between each line
//    layout.minimumInteritemSpacing = 10 // space between each item
//    layout.scrollDirection = .horizontal
    layout.itemSize = CGSize(width: CGFloat(fullSize.width) / 3 - 10,
                             height: CGFloat(fullSize.height) / 3 - 10)
    
    layout.headerReferenceSize = CGSize(width: fullSize.width, height: 40)
    layout.footerReferenceSize = CGSize(width: fullSize.width, height: 40)
    
    // create UICollectionView
    let myCollectionView = UICollectionView(frame: CGRect(x: 0,
                                                          y: 20,
                                                          width: fullSize.width,
                                                          height: fullSize.height - 20),
                                            collectionViewLayout: layout)
    myCollectionView.backgroundColor = UIColor.darkGray
    myCollectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    
    // register the header and footer of the section for reused
    myCollectionView.register(UICollectionReusableView.self,
                              forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
                              withReuseIdentifier: "Header")
    
    myCollectionView.register(UICollectionReusableView.self,
                              forSupplementaryViewOfKind: UICollectionElementKindSectionFooter,
                              withReuseIdentifier: "Footer")
    

    myCollectionView.delegate = self
    myCollectionView.dataSource = self
    self.view.addSubview(myCollectionView)

  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  // number of cell in a section
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 4
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
    
    cell.imgView.image = UIImage(named: "0\(indexPath.item + 1).jpg")
    cell.titleLabel.text = "0\(indexPath.item + 1)"
    
    return cell
  }
  
  // number of section
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 2
  }

  // Action for cell selected
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print("你選擇了第 \(indexPath.section + 1) 組的")
    print("第 \(indexPath.item + 1) 張圖片")
  }
  
  // set reuse header and footer in section
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    //Create UICollectionReusableView
    var reusableView = UICollectionReusableView()
    
    let label = UILabel(frame: CGRect(x: 0, y: 0, width: fullSize.width, height: 40))
    label.textAlignment = .center
    
    if kind == UICollectionElementKindSectionHeader {
      // header
      reusableView = collectionView.dequeueReusableSupplementaryView(
          ofKind: UICollectionElementKindSectionHeader,
          withReuseIdentifier: "Header",
          for: indexPath)
      
      //header content
      reusableView.backgroundColor = UIColor.darkGray
      label.text = "Header"
      label.textColor = UIColor.white
      
    } else if kind == UICollectionElementKindSectionFooter {
      // footer
      reusableView = collectionView.dequeueReusableSupplementaryView(
        ofKind: UICollectionElementKindSectionFooter,
        withReuseIdentifier: "Footer",
        for: indexPath)
      
      //footer content
      reusableView.backgroundColor = UIColor.cyan
      label.text = "Footer"
      label.textColor = UIColor.black
    }
    
    reusableView.addSubview(label)
    return reusableView
  }
}

