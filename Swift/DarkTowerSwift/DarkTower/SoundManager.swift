//
//  SoundManager.swift
//  DarkTower
//
//  Created by Louis Revor on 2/28/15.
//  Copyright (c) 2015 Louis Revor. All rights reserved.
//

import Foundation
import AVFoundation

class SoundManager : NSObject {
    struct Static {
        static var audioPlayer: AVAudioPlayer! = nil
    }
    class func playSound(soundName:String!) {
        // NSLog("[%@ %@]", reflect(self).summary, __FUNCTION__)
        let soundURL = NSBundle.mainBundle().URLForResource(soundName, withExtension: "wav")
        Static.audioPlayer = AVAudioPlayer(contentsOfURL: soundURL, error: nil)
        Static.audioPlayer.play()
    }
    class func isPlaying() {
        while (Static.audioPlayer.playing) {sleep(1)}
    }
}
