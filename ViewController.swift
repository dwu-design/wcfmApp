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

class ViewController: UIViewController {
    
    private var myPlayer: AVPlayer!
    private let myUrl = URL(string: "http://137.165.206.193:8000/stream")
    private var playerHasBeenInitialized = false
    private var audioSessionHasBeenActivated = false
    private var currentlyPlayingAudio = false

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
        if !playerHasBeenInitialized {
            myPlayer = AVPlayer(url: myUrl!)
        }
        myPlayer.play()
    }
    
    private func doPauseAction() {
        if let myPlayer = self.myPlayer {
            myPlayer.pause()
        }
    }
    
    @IBAction func playPauseButton(_ sender: AnyObject) {
        let button = sender as! UIButton
        if currentlyPlayingAudio {
            doPauseAction()
            currentlyPlayingAudio = false
            button.setTitle("Play", for: UIControlState.normal)
        } else {
            doPlayAction()
            currentlyPlayingAudio = true
            button.setTitle("Pause", for: UIControlState.normal)
        }
    }
}

