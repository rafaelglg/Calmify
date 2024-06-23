//
//  SoundManager.swift
//  Calmify
//
//  Created by Rafael Loggiodice on 21/6/24.
//

import Foundation
import AVKit

final class SoundManager {
    
    static let shared = SoundManager()
    private var audioPlayer: AVAudioPlayer?
    
    func getSound(forMusic musicName: String) {
        guard let url = Bundle.main.url(forResource: musicName, withExtension: "mp3") else {
            return
        }
        do {
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
