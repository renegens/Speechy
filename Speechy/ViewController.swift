//
//  ViewController.swift
//  Speechy
//
//  Created by Giwrgos Gens on 07/08/15.
//  Copyright © 2015 Giwrgos Gens. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   
    @IBOutlet weak var micButton: UIButton!
    @IBOutlet weak var recordingButton: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    
    
    
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
        
        print("Record button pressed")

    }

    @IBAction func stopButton(sender: UIButton) {
        micButton.enabled = true
        recordingButton.hidden = true
        stopButton.hidden = true
   
    }
}

