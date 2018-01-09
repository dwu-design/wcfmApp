//
//  AppDelegate.swift
//  wcfmApp
//
//  Created by williams user on 1/5/18.
//  Copyright © 2018 williams user. All rights reserved.
//
//https://github.com/mattneub/Programming-iOS-Book-Examples/blob/master/bk2ch14p643ducking/ch27p912ducking/AppDelegate.swift
//^another thing we ripped off from

import UIKit
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    /// The instance of `AssetPlaybackManager` that the app uses for managing playback.
    let assetPlaybackManager = AssetPlaybackManager()
    
    /// The instance of `RemoteCommandManager` that the app uses for managing remote command events.
    var remoteCommandManager: RemoteCommandManager!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Initializer the `RemoteCommandManager`.
        remoteCommandManager = RemoteCommandManager(assetPlaybackManager: assetPlaybackManager)
        
        // Always enable playback commands in MPRemoteCommandCenter.
        remoteCommandManager.activatePlaybackCommands(true)
        
        // Override point for customization after application launch.
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayback)
        }
        catch {
            print("Setting category to AVAudioSessionCategoryPlayback failed.")
        }
        
        // Set the AVAudioSession as active.  This is required so that your application becomes the "Now Playing" app.
        do {
            try audioSession.setActive(true, with: [])
        }
        catch {
            print("An Error occured activating the audio session: \(error)")
        }
        
        // properly, if the route changes from some kind of Headphones to Built-In Speaker,
        // we should pause our sound (doesn't happen automatically)
        
        NotificationCenter.default.addObserver(forName:
        .AVAudioSessionInterruption, object: nil, queue: nil) {
            n in
            let why = n.userInfo![AVAudioSessionInterruptionTypeKey] as! UInt
            let type = AVAudioSessionInterruptionType(rawValue: why)!
            switch type {
            case .began:
                print("interruption began:\n\(n.userInfo!)")
            case .ended:
                print("interruption ended:\n\(n.userInfo!)")
                try? AVAudioSession.sharedInstance().setActive(true)
                guard let opt = n.userInfo![AVAudioSessionInterruptionOptionKey] as? UInt else {return}
                if AVAudioSessionInterruptionOptions(rawValue:opt).contains(.shouldResume) {
                    print("should resume")
                } else {
                    print("not should resume")
                }
            }
        }
        
        // use control center to test, e.g. start and stop a Music song
        
        NotificationCenter.default.addObserver(forName:
        .AVAudioSessionSilenceSecondaryAudioHint, object: nil, queue: nil) { n in
            let why = n.userInfo![AVAudioSessionSilenceSecondaryAudioHintTypeKey] as! UInt
            let type = AVAudioSessionSilenceSecondaryAudioHintType(rawValue: why)!
            switch type {
            case .begin:
                print("silence hint begin:\n\(n.userInfo!)")
            case .end:
                print("silence hint end:\n\(n.userInfo!)")
            }
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

