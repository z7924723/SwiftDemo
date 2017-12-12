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
  var index: Int!
  
  var imgList: [UIImage] = [
    UIImage(named: "01.jpg")!,
    UIImage(named: "02.jpg")!,
    UIImage(named: "03.jpg")!,
    UIImage(named: "04.jpg")!,
    UIImage(named: "05.jpg")!
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    fullSize = UIScreen.main.bounds.size
    self.view.backgroundColor = UIColor.white
    
    // Scroll View
    scrollView = UIScrollView()
    scrollView.frame = CGRect(x: 0, y: 20, width: fullSize.width, height: fullSize.height - 20)
    // 實際視圖範圍,有幾張圖就為幾倍
    scrollView.contentSize = CGSize(width: fullSize.width * CGFloat(imgList.count),
                                    height: fullSize.height)

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
    pageControl.center = CGPoint(x: fullSize.width * 0.5, y: fullSize.height * 0.9)
    pageControl.numberOfPages = imgList.count
    pageControl.currentPage = 0 // starting page
    
    pageControl.currentPageIndicatorTintColor = UIColor.black // 目前所在頁數的點點顏色
    pageControl.pageIndicatorTintColor = UIColor.lightGray // 其餘頁數的點點顏色
    
    pageControl.addTarget(self,
                          action: #selector(ViewController.pageChanged),
                          for: .valueChanged)
    
    self.view.addSubview(pageControl)
    
    for index in 0...imgList.count - 1 {
      let imgView = UIImageView(image: imgList[index])
      imgView.frame = CGRect(x: 0, y: 0, width: fullSize.width, height: 500)
      imgView.center = CGPoint(x: fullSize.width * (0.5 + CGFloat(index)),
                               y: fullSize.height * 0.5)
      
      scrollView.addSubview(imgView)
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    // Update page number when user slide
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

