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
        case testyourmight
        case roundonefight
        case firstblood
        case getoverhere
        case dominating
        case unstoppable
        case wickedsick
        case godlike
        case rampage
        case ownage
        case holyshit
        case combowhore
        case toasty
        case excellent
        case yousuck
        case champion
        case xwins
        case zerowins
        case laugh
        case drawlaugh
        case round2
        case round3
    }
    
    func playSound(_ sound: SoundOption) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else { return }

        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player else { return }
            DispatchQueue.main.async {
                player.play()
            }
        } catch let error {
            print("Error playing sound, \(error.localizedDescription)")
        }
    }
    
    func playStop() {
        guard let player else { return }
        player.stop()
    }
}
