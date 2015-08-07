//
//  RecordSoundsViewController.swift
//  Speechy
//
//  Created by Giwrgos Gens on 07/08/15.
//  Copyright © 2015 Giwrgos Gens. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController {

   
    @IBOutlet weak var micButton: UIButton!
    @IBOutlet weak var recordingButton: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
  
    }
    
    override func viewWillAppear(animated: Bool) {
        stopButton.hidden = true
        recordingButton.hidden = true
            }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAudio(sender: UIButton) {
        
        //TODO: record user voice
        micButton.enabled = false
        recordingButton.hidden = false
        stopButton.hidden = false
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        
        let recordingName = "my_audio.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        print(filePath)
        
        let recordSettings = [AVSampleRateKey : NSNumber(float: Float(44100.0)),
            AVFormatIDKey : NSNumber(int: Int32(kAudioFormatAppleLossless)),
            AVNumberOfChannelsKey : NSNumber(int: 2),
            AVEncoderAudioQualityKey : NSNumber(int: Int32(AVAudioQuality.Max.rawValue))]
        
        
        let session = AVAudioSession.sharedInstance()
        do {
        try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
            audioRecorder = try AVAudioRecorder(URL: filePath!, settings: recordSettings)
            audioRecorder.meteringEnabled = true
            audioRecorder.prepareToRecord()
            audioRecorder.record()
        }catch{
            audioRecorder = nil
        }
        
    

    }

    @IBAction func stopButton(sender: UIButton) {
        
        let audioSession = AVAudioSession.sharedInstance()
        do{
            try audioSession.setActive(false)
        }catch{
           //do something
        }

        micButton.enabled = true
        recordingButton.hidden = true
        stopButton.hidden = true
        audioRecorder.stop()
   
    }
}

