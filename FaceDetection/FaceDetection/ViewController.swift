//
//  ViewController.swift
//  FaceDetection
//
//  Created by PinguMac on 2018/1/12.
//  Copyright © 2018年 PinguMac. All rights reserved.
//

import UIKit
import Vision
import AVFoundation

class ViewController: UIViewController {

  var imgView: UIImageView!
  var testImg = UIImage(named: "TheCranberries.jpg")
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    let ScreenSize = UIScreen.main.bounds.size
    
    guard let image = testImg else {
      print("No image.")
      return
    }
    
    imgView = UIImageView(image: image)
    imgView.contentMode = .scaleAspectFit
    imgView.frame = CGRect(x: 0,
                           y: 0,
                           width: ScreenSize.width,
                           height: ScreenSize.height)
    view.addSubview(imgView)
    
    let tapGesture = UITapGestureRecognizer(target: self,
                                            action: #selector(facesDetection(tapGestureRecognizer:)))
    imgView.isUserInteractionEnabled = true
    imgView.addGestureRecognizer(tapGesture)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func facesDetection(tapGestureRecognizer: UITapGestureRecognizer) {
    let detectRequest = VNDetectFaceRectanglesRequest(completionHandler: self.handleFaces)
    let detectRequestHandler = VNImageRequestHandler(cgImage: (testImg?.cgImage)!, options: [ : ])
    do {
      try detectRequestHandler.perform([detectRequest])
    } catch {
      print(error)
    }
  }
  
  func handleFaces(request: VNRequest, error: Error?) {
    guard let faceDetectResults = request.results as? [VNFaceObservation] else {
      fatalError("Unexpected result type from VNDetectFaceRetanglesRequest.")
    }

    if faceDetectResults.count == 0 {
      print("No face detect.")
      return
    }
    
    self.addSharpToFace(forObservations: faceDetectResults)
  }
  
  func addSharpToFace(forObservations observations: [VNFaceObservation]) {
    if let sublayers = imgView.layer.sublayers {
      for layer in sublayers {
        layer.removeFromSuperlayer()
      }
    }

    let imageRect = AVMakeRect(aspectRatio: (testImg?.size)!, insideRect: imgView.bounds)
    let layers: [CAShapeLayer] = observations.map { observation in
      let width = observation.boundingBox.size.width * imageRect.width
      let height = observation.boundingBox.size.height * imageRect.height
      let x = observation.boundingBox.origin.x * imageRect.width
      let y = imageRect.maxY - (observation.boundingBox.origin.y * imageRect.height) - height

      let layer = CAShapeLayer()
      layer.frame = CGRect(x: x, y: y, width: width, height: height)
      layer.borderColor = UIColor.red.cgColor
      layer.borderWidth = 2
      layer.cornerRadius = 3
      return layer
    }

    for layer in layers {
      imgView.layer.addSublayer(layer)
    }
  }
}
