//
//  ViewController.swift
//  AudioPlayer
//
//  Created by PinguMac on 2017/12/21.
//  Copyright © 2017年 PinguMac. All rights reserved.
//

import UIKit
import AVFoundation

class PlayerVC: UIViewController {
  
  var musicProgress: UISlider!
  var musicVolume: UISlider!
  
  var playBtn: UIButton!
  var pauseBtn: UIButton!
  var stopBtn: UIButton!
  var audioPlayer: AVAudioPlayer!
  var volLabel: UILabel!
  var progressTimer: Timer?
  var defaultVol: Float = 0.5

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    let ScreenSize = UIScreen.main.bounds.size
    self.view.backgroundColor = UIColor.white
    
    // prepare file
    prepareAudioFile()
    
    // music Progress slider
    musicProgress = UISlider(frame: CGRect(x: 0,
                                           y: 0,
                                           width: ScreenSize.width * 0.8,
                                           height: 50))
    musicProgress.center = CGPoint(x: ScreenSize.width * 0.5,
                                   y: ScreenSize.height * 0.3)
    musicProgress.minimumTrackTintColor = UIColor.red
    musicProgress.maximumTrackTintColor = UIColor.gray
    musicProgress.minimumValue = 0
    musicProgress.maximumValue = Float(audioPlayer.duration)
    musicProgress.isContinuous = true
    musicProgress.addTarget(self,
                            action: #selector(PlayerVC.progressChangeAct),
                            for: .touchUpInside)
    self.view.addSubview(musicProgress)

    // Play Button
    playBtn = UIButton(frame: CGRect(x: musicProgress.frame.minX,
                                     y: musicProgress.frame.maxY + 15,
                                     width: 100,
                                     height: 30))
    playBtn.setTitle("Play", for: .normal)
    playBtn.backgroundColor = UIColor.blue
    playBtn.addTarget(nil,
                      action: #selector(PlayerVC.palyBtnAction),
                      for: .touchDown)
    self.view.addSubview(playBtn)
    
    // Pause Buttom
    pauseBtn = UIButton(frame: CGRect(x: playBtn.frame.maxX + 20,
                                     y: musicProgress.frame.maxY + 15,
                                     width: 100,
                                     height: 30))
    
    pauseBtn.setTitle("Pause", for: .normal)
    pauseBtn.backgroundColor = UIColor.blue
    pauseBtn.addTarget(nil,
                      action: #selector(PlayerVC.pauseBtnAction),
                      for: .touchDown)
    self.view.addSubview(pauseBtn)
    
    // Stop Buttom
    stopBtn = UIButton(frame: CGRect(x: pauseBtn.frame.maxX + 20,
                                     y: musicProgress.frame.maxY + 15,
                                     width: 100,
                                     height: 30))
    
    stopBtn.setTitle("Stop", for: .normal)
    stopBtn.backgroundColor = UIColor.blue
    stopBtn.addTarget(nil,
                      action: #selector(PlayerVC.stopBtnAction),
                      for: .touchDown)
    self.view.addSubview(stopBtn)

    // label for text and volume value
    let textLab = UILabel(frame:CGRect(x: ScreenSize.width / 3,
                                       y: stopBtn.frame.maxY + 50,
                                       width: 100,
                                       height: 30))
    textLab.text = "Volume"
    self.view.addSubview(textLab)

    volLabel = UILabel(frame:CGRect(x: textLab.frame.maxX,
                                    y: stopBtn.frame.maxY + 50,
                                    width: 50,
                                    height: 30))
    volLabel.text = String(lroundf(defaultVol * 100))
    self.view.addSubview(volLabel)

    // Slider Bar for change volume
    musicVolume = UISlider(frame: CGRect(x: musicProgress.frame.minX,
                                         y: volLabel.frame.maxY + 20,
                                         width: ScreenSize.width * 0.8,
                                         height: 50))
    musicVolume.minimumTrackTintColor = UIColor.red
    musicVolume.maximumTrackTintColor = UIColor.gray
    musicVolume.minimumValue = 0
    musicVolume.maximumValue = 1
    musicVolume.value = defaultVol
    musicVolume.isContinuous = true
    musicVolume.addTarget(self,
                       action: #selector(PlayerVC.volumeChangeAct),
                       for: .valueChanged)
    self.view.addSubview(musicVolume)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func progressChangeAct(_ sender: UISlider) {
    audioPlayer.currentTime = TimeInterval(sender.value)
  }
  
  @IBAction func palyBtnAction(sender: AnyObject) {
    audioPlayer.play()

    if progressTimer == nil {
      progressTimer = Timer.scheduledTimer(timeInterval: 1,
                                           target: self,
                                           selector: #selector(PlayerVC.updateProgressSlider),
                                           userInfo: nil,
                                           repeats: true)
    }
  }
  
  @IBAction func updateProgressSlider(sender: AnyObject) {
    musicProgress.value = Float(audioPlayer.currentTime)
  }
  
  @IBAction func pauseBtnAction() {
    stopTimeInterval()
    audioPlayer.pause()
  }
  
  @IBAction func stopBtnAction() {
    stopTimeInterval()
    audioPlayer.stop()
    audioPlayer.currentTime = 0
    musicProgress.value = 0
  }
  
  @IBAction func volumeChangeAct(_ sender: UISlider) {
    audioPlayer.volume = sender.value
    volLabel.text = String(lroundf(sender.value * 100))
  }
  
  func stopTimeInterval() {
    if progressTimer != nil {
      progressTimer?.invalidate()
      progressTimer = nil
    }
  }
  
  func prepareAudioFile() {
    let url = Bundle.main.url(forResource: "ISeeFire", withExtension: "mp3")
    
    do {
      audioPlayer = try AVAudioPlayer(contentsOf: url!)
      audioPlayer.prepareToPlay()
    } catch {
      print("Error:", error.localizedDescription)
    }
  }
}
