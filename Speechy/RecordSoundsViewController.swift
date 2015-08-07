//
//  RecordSoundsViewController.swift
//  Speechy
//
//  Created by Giwrgos Gens on 07/04/15.
//  Copyright © 2015 Giwrgos Gens. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController,AVAudioRecorderDelegate {

   
    @IBOutlet weak var micButton: UIButton!
    @IBOutlet weak var recordingButton: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    var recordSession: AVAudioSession!
    var recordedAudio: RecordedAudio!
    
    
    
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
        
        //setting name and path for file
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        let recordingName = "my_audio.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        let recordSettings = [AVEncoderAudioQualityKey: AVAudioQuality.Min.rawValue,
            AVEncoderBitRateKey: 16,
            AVNumberOfChannelsKey: 2,
            AVSampleRateKey: 44100.0]
        print(filePath)
        
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
            audioRecorder = try AVAudioRecorder(URL: filePath!, settings: recordSettings as! [String : AnyObject])
        } catch _ {
            print("Error")
        }
        
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        
        if flag {
            //save the recorded audio
            recordedAudio = RecordedAudio()
            recordedAudio.filePathUrl = recorder.url
            recordedAudio.title = recorder.url.lastPathComponent
        
            //move to the seque
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        }else{
            print("Recording not sucessful")
            micButton.enabled = true
            recordingButton.hidden = true
            stopButton.hidden = true
            
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "stopRecording" {
            let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            let data = sender as! RecordedAudio
            playSoundsVC.receivedAudio = data
        }
    }

    @IBAction func stopButton(sender: UIButton) {
        
        micButton.enabled = true
        recordingButton.hidden = true
        stopButton.hidden = true
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        do{
            try audioSession.setActive(false)
        }
        catch{
             print("Error")
        }
    }
}

