//
//  PlaySound.swift
//  Learn by Doing
//
//  Created by Vikas Vaish on 02/03/23.
//

import Foundation
import AVFoundation
//MARK: -  AUDIO PLAYER

var audioPlayer: AVAudioPlayer?

func playSound(sound: String,type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        } catch {
            print("could not find and play the sound file")
        }
    }
}
