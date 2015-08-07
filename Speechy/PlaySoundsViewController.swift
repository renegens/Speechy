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

    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            audioPlayer = try AVAudioPlayer(contentsOfURL: NSURL (fileURLWithPath: NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3")!), fileTypeHint:nil)
            audioPlayer.enableRate = true
        } catch {
            //Handle the error
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
