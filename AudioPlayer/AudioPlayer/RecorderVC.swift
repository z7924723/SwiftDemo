//
//  RecoderVC.swift
//  AudioPlayer
//
//  Created by PinguMac on 2017/12/25.
//  Copyright © 2017年 PinguMac. All rights reserved.
//

import UIKit
import AVFoundation

class RecorderVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
  
  var recordBtn: UIButton!
  var recordingSession: AVAudioSession!
  var audioRecorder: AVAudioRecorder!
  var audioPlayer: AVAudioPlayer!
  var tableView: UITableView!
  var numOfRecorder: Int = 0

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    let ScreenSize = UIScreen.main.bounds.size
    self.view.backgroundColor = UIColor.white
    
    // Record Button
    recordBtn = UIButton(frame: CGRect(x: 0,
                                       y: 0,
                                       width: 100,
                                       height: 30))
    recordBtn.center = CGPoint(x: ScreenSize.width * 0.5,
                               y: ScreenSize.height * 0.1)
    recordBtn.setTitle("Record", for: .normal)
    recordBtn.backgroundColor = UIColor.blue
    recordBtn.addTarget(nil,
                      action: #selector(RecorderVC.recordBtnAction),
                      for: .touchDown)
    self.view.addSubview(recordBtn)
    
    // Table view for record file
    tableView = UITableView(frame: CGRect(x: 0,
                                          y: recordBtn.frame.maxY + 100,
                                          width: ScreenSize.width,
                                          height: ScreenSize.height / 2),
                                style: .plain)
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    
    tableView.delegate = self
    tableView.dataSource = self
    self.view.addSubview(tableView)
    
    if let number: Int = UserDefaults.standard.object(forKey: "myNumber") as? Int {
      numOfRecorder = number
    }
    
    // Configure record session
    configRecordSession()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func recordBtnAction() {
    if audioRecorder == nil {
      numOfRecorder += 1
      
      let destinationUrl = getDirectoryPath().appendingPathComponent("\(numOfRecorder).m4a")
     
      let settings = [AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                      AVSampleRateKey: 44100,
                      AVNumberOfChannelsKey: 2,
                      AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
                     ]
      
      do {
        audioRecorder = try AVAudioRecorder(url: destinationUrl, settings: settings)
        audioRecorder.record()
        
        recordBtn.setTitle("Stop", for: .normal)
      } catch {
        print("Record error:", error.localizedDescription)
      }
    } else {
      audioRecorder.stop()
      audioRecorder = nil
      
      // save file name of record data in tableview
      UserDefaults.standard.set(numOfRecorder, forKey: "myNumber")
      tableView.reloadData()
      
      recordBtn.setTitle("Record", for: .normal)
    }
  }
  
  func getDirectoryPath() -> URL {
    // create document folder url
    let fileDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    return fileDirectoryURL
  }
  
  func configRecordSession() {
    recordingSession = AVAudioSession.sharedInstance()
    
    do {
      try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
      try recordingSession.setActive(true)
      recordingSession.requestRecordPermission() { permissionAllowed in
        if permissionAllowed {

        } else {
          // failed to record!
        }
      }
    } catch {
      print("Session error:", error.localizedDescription)
    }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return numOfRecorder
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    
    cell.textLabel?.text = String(indexPath.row + 1)
    cell.detailTextLabel?.text = String("aaa")
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let recordFilePath = getDirectoryPath().appendingPathComponent("\(indexPath.row + 1).m4a")
    do {
      audioPlayer = try AVAudioPlayer(contentsOf: recordFilePath)
      audioPlayer.play()
    } catch {
      print("Play error:", error.localizedDescription)
    }
  }
}
