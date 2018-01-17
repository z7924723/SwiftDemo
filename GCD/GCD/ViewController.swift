//
//  ViewController.swift
//  GCD
//
//  Created by PinguMac on 2018/1/16.
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

  @IBAction func sliderValChanged(sender: UISlider) {
    self.sliderValLabel.text = "\(lroundf(sender.value))"
  }
  
  // No dispatch queue
//  @IBAction func didClickOnStart(sender: AnyObject) {
//    let img1 = downloadImageWithURL(url: imageURLs[0])
//    self.imageView1.image = img1
//
//    let img2 = downloadImageWithURL(url: imageURLs[1])
//    self.imageView2.image = img2
//
//    let img3 = downloadImageWithURL(url: imageURLs[2])
//    self.imageView3.image = img3
//
//    let img4 = downloadImageWithURL(url: imageURLs[3])
//    self.imageView4.image = img4
//  }
  
  // Concurrent dispatch queue: download image at global queue and update UI at main queue
  @IBAction func didClickOnStart(sender: AnyObject) {
    let concurrentQueue = DispatchQueue(label: "concurrentQueue", attributes: .concurrent)

    concurrentQueue.async() {
      let img1 = self.downloadImageWithURL(url: self.imageURLs[0])
      DispatchQueue.main.async(execute: {
        self.imageView1.image = img1
      })
    }

    concurrentQueue.async {
      let img2 = self.downloadImageWithURL(url: self.imageURLs[1])
      DispatchQueue.main.async(execute: {
        self.imageView2.image = img2
      })
    }

    concurrentQueue.async() {
      let img3 = self.downloadImageWithURL(url: self.imageURLs[2])
      DispatchQueue.main.async(execute: {
        self.imageView3.image = img3
      })
    }

    concurrentQueue.async() {
      let img4 = self.downloadImageWithURL(url: self.imageURLs[3])
      DispatchQueue.main.async(execute: {
        self.imageView4.image = img4
      })
    }
  }
  
  // Serial dispatch queue
//  @IBAction func didClickOnStart(sender: AnyObject) {
//    let serialQueue: DispatchQueue = DispatchQueue(label: "serialQueue")
//
//    serialQueue.async() { () -> Void in
//      let img1 = self.downloadImageWithURL(url: self.imageURLs[0])
//      DispatchQueue.main.async(execute: {
//        self.imageView1.image = img1
//      })
//    }
//
//    serialQueue.async() { () -> Void in
//      let img2 = self.downloadImageWithURL(url: self.imageURLs[1])
//      DispatchQueue.main.async(execute: {
//        self.imageView2.image = img2
//      })
//    }
//
//    serialQueue.async() { () -> Void in
//      let img3 = self.downloadImageWithURL(url: self.imageURLs[2])
//      DispatchQueue.main.async(execute: {
//        self.imageView3.image = img3
//      })
//    }
//
//    serialQueue.async() { () -> Void in
//      let img4 = self.downloadImageWithURL(url: self.imageURLs[3])
//      DispatchQueue.main.async(execute: {
//        self.imageView4.image = img4
//      })
//    }
//  }
  
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
