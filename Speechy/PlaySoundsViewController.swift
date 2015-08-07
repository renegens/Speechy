//
//  PlaySoundsViewController.swift
//  Speechy
//
//  Created by Giwrgos Gens on 07/04/15.
//  Copyright © 2015 Giwrgos Gens. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer:AVAudioPlayer!
    var receivedAudio: RecordedAudio!

    override func viewDidLoad() {
        super.viewDidLoad()

        do{
        try audioPlayer =  AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
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
        
       audioPlayer(0.5)
    }
    
    @IBAction func rabbitAction(sender: UIButton) {
        
        audioPlayer(1.5)
    }

    @IBAction func stopAction(sender: UIButton) {
        
        audioPlayer.stop()
    }
    
    func audioPlayer(rate: Float){
        
        audioPlayer.stop()
        audioPlayer.rate = rate
        audioPlayer.play()
        
    }
}
