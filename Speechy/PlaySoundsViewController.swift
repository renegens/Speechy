//
//  PlaySoundsViewController.swift
//  Speechy
//
//  Created by Giwrgos Gens on 07/08/15.
//  Copyright © 2015 Giwrgos Gens. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer:AVAudioPlayer!
    var receivedAudio: RecordedAudio!
    var audioEngine: AVAudioEngine!
    var audioFile:AVAudioFile!


    override func viewDidLoad() {
        super.viewDidLoad()
        audioEngine = AVAudioEngine()
        
        do{
        try audioPlayer =  AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
        try audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl)
            audioPlayer.enableRate = true
        }catch{
            print(error)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func snailAction(sender: UIButton) {
        
       audioPlayer(1)
    }
    
    @IBAction func rabbitAction(sender: UIButton) {
        
        audioPlayer(1.5)
    }

    @IBAction func stopAction(sender: UIButton) {
        
        audioPlayer.stop()
    }
    @IBAction func chipMunkAction(sender: UIButton) {
        
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func vaderAction(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    
    func audioPlayer(rate: Float){
        
        audioPlayer.stop()
        audioPlayer.rate = rate
        audioPlayer.play()
        
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        do {
        try audioEngine.start()
        }catch{
            //something
        }
        
        audioPlayerNode.play()
    }
}
