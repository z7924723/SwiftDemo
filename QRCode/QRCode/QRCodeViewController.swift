//
//  ViewController.swift
//  QRCode
//
//  Created by PinguMac on 2018/5/17.
//  Copyright © 2018年 PinguMac. All rights reserved.
//

import UIKit
import AVFoundation

class QRCodeViewController: UIViewController {

  @IBOutlet weak var videoPreview: UIView!

  let avCaptureSession = AVCaptureSession()
  var qrCodeString = String()
  
  enum error: Error {
    case noCameraAvailable
    case videoInputInitFail
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    
    do {
      try scanQrCode()
    } catch {
      print("Failed to scan the QR code.")
    }
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "OpenLink" {
      let destination = segue.destination as! PresentDataViewController
        destination.qrCodeString = qrCodeString
    }
  }
}

extension QRCodeViewController: AVCaptureMetadataOutputObjectsDelegate {
  func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
    if metadataObjects.count > 0 {
      let machineReadableCode = metadataObjects.first as! AVMetadataMachineReadableCodeObject
      
      if machineReadableCode.type == AVMetadataObject.ObjectType.qr {
        qrCodeString = machineReadableCode.stringValue!
        
        if checkQRCodeVaild(qrCode: qrCodeString) {
          print(qrCodeString)
          avCaptureSession.stopRunning()
          performSegue(withIdentifier: "OpenLink", sender: self)
        }
      }
    }
  }
  
  // MARK: - Help Method
  private func scanQrCode() throws {
    guard let avCaptureDevice = AVCaptureDevice.default(for: AVMediaType.video) else {
      print("No Camera.")
      throw error.noCameraAvailable
    }
    
    guard let avCaptureInput = try? AVCaptureDeviceInput(device: avCaptureDevice) else {
      print("Failed to init camera.")
      throw error.videoInputInitFail
    }
    
    let avCaptureMetadataOutput = AVCaptureMetadataOutput()
    avCaptureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
    
    avCaptureSession.addInput(avCaptureInput)
    avCaptureSession.addOutput(avCaptureMetadataOutput)

    avCaptureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
    
    let avCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: avCaptureSession)
    avCaptureVideoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
    avCaptureVideoPreviewLayer.frame = videoPreview.bounds
    
    self.videoPreview.layer.addSublayer(avCaptureVideoPreviewLayer)
    
    avCaptureSession.startRunning()
  }
  
  private func checkQRCodeVaild(qrCode: String) -> Bool {
    let prefixString = qrCodeString.prefix(7)
    guard prefixString == "AppCamp" else {
      return false
    }
    return true
  }
}
