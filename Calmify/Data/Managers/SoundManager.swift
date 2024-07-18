//
//  SoundManager.swift
//  Calmify
//
//  Created by Rafael Loggiodice on 21/6/24.
//

import Foundation
import AVKit
private var audioPlayer: AVAudioPlayer? // the place needs to be here, to be global, and to avoid warnings in the console


final class SoundManager {
    
    static let shared = SoundManager()
    
    func getSound(forMusic musicName: String) {
        guard let url = Bundle.main.url(forResource: musicName, withExtension: "mp3") else {
            return
        }
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            audioPlayer = try AVAudioPlayer(contentsOf: url)
        } catch let error {
            print("error Playing Music \(error.localizedDescription)")
        }
    }
    
    func playSound() {
        audioPlayer?.play()
    }
    
    func stopPlayingSound() {
        audioPlayer?.stop()
    }
    
    func rewindSound() {
        audioPlayer?.currentTime = 0
    }
    
}
