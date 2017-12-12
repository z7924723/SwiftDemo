//
//  ViewController.swift
//  ImageSlider
//
//  Created by PinguMac on 2017/12/11.
//  Copyright © 2017年 PinguMac. All rights reserved.
//

import UIKit

let pageNum = 5

class ViewController: UIViewController, UIScrollViewDelegate {

  var scrollView: UIScrollView!
  var pageControl: UIPageControl!
  var fullSize: CGSize!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    fullSize = UIScreen.main.bounds.size
    self.view.backgroundColor = UIColor.white
    
    // Scroll View
    scrollView = UIScrollView()
    scrollView.frame = CGRect(x: 0, y: 20, width: fullSize.width, height: fullSize.height - 20)
    // 實際視圖範圍
    scrollView.contentSize = CGSize(width: fullSize.width * 5, height: fullSize.height - 20)

    // 是否顯示滑動條
    scrollView.showsHorizontalScrollIndicator = false
    scrollView.showsVerticalScrollIndicator = false
    
    // 滑動超過範圍時是否使用彈回效果
    scrollView.bounces = true
    scrollView.isPagingEnabled = true
    scrollView.delegate = self
    self.view.addSubview(scrollView)
    
    // Page controller
    pageControl = UIPageControl(frame: CGRect(x: 0,
                                              y: 0,
                                              width: fullSize.width * 0.85,
                                              height: 50))
    pageControl.center = CGPoint(x: fullSize.width * 0.5, y: fullSize.height * 0.85)
    pageControl.numberOfPages = pageNum
    pageControl.currentPage = 0
    
    pageControl.currentPageIndicatorTintColor = UIColor.black // 目前所在頁數的點點顏色
    pageControl.pageIndicatorTintColor = UIColor.lightGray // 其餘頁數的點點顏色
    
    pageControl.addTarget(self,
                          action: #selector(ViewController.pageChanged),
                          for: .valueChanged)
    
    self.view.addSubview(pageControl)
    
    
    var myLabel = UILabel()
    for i in 0...4 {
      myLabel = UILabel(frame: CGRect(x: 0, y: 0, width: fullSize.width, height: 40))
      myLabel.center = CGPoint(x: fullSize.width * (0.5 + CGFloat(i)),
                               y: fullSize.height * 0.2)
      myLabel.font = UIFont(name: "Helvetica-Light", size: 48.0)
      myLabel.textAlignment = .center
      myLabel.text = "\(i + 1)"
      scrollView.addSubview(myLabel)
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    // 左右滑動到新頁時 更新 UIPageControl 顯示的頁數
    let page = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
    pageControl.currentPage = page
  }
  
  @IBAction func pageChanged(_ sender: UIPageControl) {
    // 依照目前圓點在的頁數算出位置
    var frame = scrollView.frame
    frame.origin.x = frame.size.width * CGFloat(sender.currentPage)
    frame.origin.y = 0
    
    // 再將 UIScrollView 滑動到該點
    scrollView.scrollRectToVisible(frame, animated:true)
  }
}

