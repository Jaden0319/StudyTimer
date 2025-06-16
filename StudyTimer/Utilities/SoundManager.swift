//
//  SoundManager.swift
//  StudyTimer
//
//  Created by Jaden Creech on 6/9/25.
//

import Foundation
import AVFoundation

class SoundManager {
    
    static let shared = SoundManager()
    private var soundEffectPlayer: AVAudioPlayer?
    private var backgroundMusicPlayer: AVAudioPlayer?
    
    
    
    func playImportedSound(named soundName: String) {
        if let url = Bundle.main.url(forResource: soundName, withExtension: ".mp3") {
            do {
                soundEffectPlayer = try AVAudioPlayer(contentsOf: url)
                soundEffectPlayer?.play()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
                    self.soundEffectPlayer?.stop()
                 }
                
            } catch {
                print("err playing sound")
            }
        }else {
            print( "sound file not found \(soundName)")
        }
    }
    
    func toggleBackgroundTicking(isOn: Bool) {
        if isOn {
            if let url = Bundle.main.url(forResource: "ticking_clock", withExtension: ".mp3") {
                do {
                    backgroundMusicPlayer = try AVAudioPlayer(contentsOf: url)
                    backgroundMusicPlayer?.numberOfLoops = -1 // inf times
                    backgroundMusicPlayer?.volume = 0.5
                    backgroundMusicPlayer?.play()
                } catch {
                    print("Error Playing BGM")
                }
            }
        } else {
            backgroundMusicPlayer?.stop()
        }
    }
}
