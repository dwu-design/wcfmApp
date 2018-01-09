//
//  ViewController.swift
//  wcfmApp
//
//  Created by williams user on 1/5/18.
//  Copyright © 2018 williams user. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import MediaPlayer

class ViewController: UIViewController {
    
    private var playerHasBeenInitialized = false
    private var audioSessionHasBeenActivated = false
    
    @IBOutlet weak var playButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func activateAudioSession() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            // Configure audio session category, options, and mode
            try audioSession.setCategory(AVAudioSessionCategoryPlayback)
            // Activate audio session to enable custom configuration
            try audioSession.setActive(true)
        } catch let error as NSError {
            print("Unable to activate audio session: \(error.localizedDescription)")
        }
    }
    
    private func doPlayAction() {
        if !audioSessionHasBeenActivated{
            activateAudioSession()
        }
        RadioPlayer.sharedInstance.play()
        playButton.setTitle("Play", for: UIControlState.normal)
    }
    
    private func doPauseAction() {
        RadioPlayer.sharedInstance.pause()
        playButton.setTitle("Pause", for: UIControlState.normal)
    }
    
    @IBAction func resetPlayer(_ sender: AnyObject) {
        RadioPlayer.sharedInstance.reset()
        doPlayAction()
    }
    
    @IBAction func playPauseButton(_ sender: AnyObject) {
        if RadioPlayer.sharedInstance.currentlyPlaying() {
            doPauseAction()
        } else {
            doPlayAction()
        }
    }

}

