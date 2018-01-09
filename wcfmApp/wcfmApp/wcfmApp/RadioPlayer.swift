//
//  RadioPlayer.swift
//  wcfmApp
//
//  Created by williams user on 1/9/18.
//  Copyright © 2018 williams user. All rights reserved.
//
//https://stackoverflow.com/questions/32614060/avplayer-audio-buffering-from-live-stream
//^what we ripped off from

import Foundation
import AVFoundation
import AVKit
import UIKit

protocol errorMessageDelegate {
    func errorMessageChanged(newVal: String)
}

protocol sharedInstanceDelegate {
    func sharedInstanceChanged(newVal: Bool)
}

class RadioPlayer : NSObject {
    static let sharedInstance = RadioPlayer()
    var instanceDelegate:sharedInstanceDelegate? = nil
    var sharedInstanceBool = false {
        didSet {
            if let delegate = self.instanceDelegate {
                delegate.sharedInstanceChanged(newVal: self.sharedInstanceBool)
            }
        }
    }
    
    private var myPlayer = AVPlayer(url: URL(string: "http://137.165.206.193:8000/stream")!)
    private var isPlaying = false
    
    var errorDelegate:errorMessageDelegate? = nil
    var errorMessage = "" {
        didSet {
            if let delegate = self.errorDelegate {
                delegate.errorMessageChanged(newVal: self.errorMessage)
            }
        }
    }
    
    func play() {
        myPlayer.play()
        isPlaying = true
    }
    
    func pause() {
        myPlayer.pause()
        isPlaying = false
    }
    
    func currentlyPlaying() -> Bool {
        return isPlaying
    }
    
    func reset() {
        self.myPlayer = AVPlayer(url: URL(string: "http://137.165.206.193:8000/stream")!)
        self.sharedInstanceBool = true
    }

}
