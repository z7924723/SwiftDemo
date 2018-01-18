//
//  ViewController.swift
//  OperationDemo
//
//  Created by PinguMac on 2018/1/18.
//  Copyright © 2018年 PinguMac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  let imageURLs = ["http://www.planetware.com/photos-large/F/france-paris-eiffel-tower.jpg",
                   "http://www.planetware.com/photos-large/F/france-louvre-museum-2.jpg",
                   "http://www.planetware.com/photos-large/F/france-versailles.jpg",
                   "http://www.planetware.com/photos-large/F/france-cote-d-azure.jpg"]
  
  var imageView1: UIImageView!
  var imageView2: UIImageView!
  var imageView3: UIImageView!
  var imageView4: UIImageView!
  var sliderValLabel: UILabel!
  var sliderBar: UISlider!
  
  var queue: OperationQueue!
  var operation1: BlockOperation!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    let ScreenSize = UIScreen.main.bounds.size
    let yPosition = statusBarHeight() + naviBarHeight()
    
    self.view.backgroundColor = UIColor.white
    
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Start",
                                                             style: .plain,
                                                             target: self,
                                                             action: #selector(ViewController.didClickOnStart))
    
    self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                             style: .plain,
                                                             target: self,
                                                             action: #selector(ViewController.didClickOnCancel))
    
    imageView1 = UIImageView()
    imageView1.contentMode = .scaleAspectFit
    imageView1.frame = CGRect(x: 0,
                              y: yPosition,
                              width: ScreenSize.width / 2,
                              height: ScreenSize.height / 3)
    view.addSubview(imageView1)
    
    imageView2 = UIImageView()
    imageView2.contentMode = .scaleAspectFit
    imageView2.frame = CGRect(x: imageView1.frame.maxX,
                              y: yPosition,
                              width: ScreenSize.width / 2,
                              height: ScreenSize.height / 3)
    view.addSubview(imageView2)
    
    imageView3 = UIImageView()
    imageView3.contentMode = .scaleAspectFit
    imageView3.frame = CGRect(x: 0,
                              y: imageView1.frame.maxY,
                              width: ScreenSize.width / 2,
                              height: ScreenSize.height / 3)
    view.addSubview(imageView3)
    
    imageView4 = UIImageView()
    imageView4.contentMode = .scaleAspectFit
    imageView4.frame = CGRect(x: imageView3.frame.maxX,
                              y: imageView2.frame.maxY,
                              width: ScreenSize.width / 2,
                              height: ScreenSize.height / 3)
    view.addSubview(imageView4)
    
    sliderValLabel = UILabel(frame:CGRect(x: 0,
                                          y: 0,
                                          width: 50,
                                          height: 30))
    sliderValLabel.center = CGPoint(x: ScreenSize.width * 0.5,
                                    y: ScreenSize.height * 0.85)
    sliderValLabel.text = String("50")
    self.view.addSubview(sliderValLabel)
    
    // slider bar
    sliderBar = UISlider(frame: CGRect(x: 0,
                                       y: 0,
                                       width: ScreenSize.width * 0.8,
                                       height: 50))
    sliderBar.center = CGPoint(x: ScreenSize.width * 0.5,
                               y: ScreenSize.height * 0.9)
    sliderBar.minimumTrackTintColor = UIColor.red
    sliderBar.maximumTrackTintColor = UIColor.gray
    sliderBar.minimumValue = 0
    sliderBar.maximumValue = 100
    sliderBar.value = 50
    sliderBar.isContinuous = true
    sliderBar.addTarget(self,
                        action: #selector(ViewController.sliderValChanged),
                        for: .valueChanged)
    self.view.addSubview(sliderBar)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func didClickOnStart(sender: AnyObject) {
    queue = OperationQueue()
    
    operation1 = BlockOperation(block: {
      let img1 = self.downloadImageWithURL(url: self.imageURLs[0])
      OperationQueue.main.addOperation({
        self.imageView1.image = img1
      })
    })
    
    operation1.completionBlock = {
      print("Operation 1 completed, cancelled:\(self.operation1.isCancelled)")
    }
    queue.addOperation(operation1)
    
    let operation2 = BlockOperation(block: {
      let img2 = self.downloadImageWithURL(url: self.imageURLs[1])
      OperationQueue.main.addOperation({
        self.imageView2.image = img2
      })
    })
    operation2.addDependency(operation1)
    operation2.completionBlock = {
      print("Operation 2 completed, cancelled:\(operation2.isCancelled)")
    }
    queue.addOperation(operation2)
    
    let operation3 = BlockOperation(block: {
      let img3 = self.downloadImageWithURL(url: self.imageURLs[2])
      OperationQueue.main.addOperation({
        self.imageView3.image = img3
      })
    })
    operation3.addDependency(operation2)
    operation3.completionBlock = {
      print("Operation 3 completed, cancelled:\(operation3.isCancelled)")
    }
    queue.addOperation(operation3)
    
    let operation4 = BlockOperation {
      let img4 = self.downloadImageWithURL(url: self.imageURLs[3])
      OperationQueue.main.addOperation {
        self.imageView4.image = img4
      }
    }
    operation4.completionBlock = {
      print("Operation 4 completed, cancelled:\(operation4.isCancelled)")
    }
    queue.addOperation(operation4)
  }
  
  @IBAction func didClickOnCancel(sender: AnyObject) {
    self.queue.cancelAllOperations()
//    operation1.cancel()
  }
  
  @IBAction func sliderValChanged(sender: UISlider) {
    self.sliderValLabel.text = "\(lroundf(sender.value))"
  }
  
  func downloadImageWithURL(url: String) -> UIImage! {
    let url = URL(string: url)
    let data = try? Data(contentsOf: url!)
    return UIImage(data: data!)
  }
  
  func statusBarHeight() -> CGFloat {
    let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
    return statusBarHeight
  }
  
  func naviBarHeight() -> CGFloat {
    let naviBarHeight = (UIApplication.shared.keyWindow?.rootViewController as! UINavigationController).navigationBar.frame.height
    return naviBarHeight
  }
}

