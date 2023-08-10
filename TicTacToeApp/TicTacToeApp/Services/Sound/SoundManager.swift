//
//  SoundManager.swift
//  TicTacToeApp
//
//  Created by Alexander Vagin on 10.08.2023.
//

import Foundation
import AVKit

final class SoundManager {
    
    static let instance = SoundManager()
    
    var player: AVAudioPlayer?
    
    enum SoundOption: String {
        case firstblood
    }
    
    func playSound(_ sound: SoundOption) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("Error playing sound, \(error.localizedDescription)")
        }
    }
}
