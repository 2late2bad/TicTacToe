//
//  Resources.swift
//  TicTacToeApp
//
//  Created by Alexander Vagin on 12.06.2023.
//

import UIKit
import SwiftUI

typealias R = Resources

enum Resources {
    
    enum Strings {
        static let easyDifficalty = "🤡"
        static let hardDifficalty = "👺"
        static let hellDifficalty = "🗿"
        
        static let game             = "TIC TAC TOE"
        static let goButton         = "GO!"
        static let typeGamePicker   = "Type game"
        static let complexityPicker = "Complexity"
        static let roundsToWin      = "Rounds to win"
    }
    
    enum Indicators {
        static let rangeOfRounds: ClosedRange = 1...6
        
        enum Grid {
            static let indentLines: CGFloat = 16
            static let thickness: CGFloat   = 2
            static let opacity: Double      = 0.2
        }
        
        enum Cross {
            static let angleForce: CGFloat = 0.12
        }
        
        enum Circle {
            static let lineWidthDesk: CGFloat  = 10
            static let lineWidthExtra: CGFloat = 2
        }
    }
    
    enum Images {
        static let infoScreenButton: String     = "questionmark.circle"
        static let settingsScreenButton: String = "gearshape"
        static let exitGameButton: String       = "xmark.circle"
        static let muteOnButton: String        = "speaker.slash.fill"
        static let muteOffButton: String       = "speaker"
    }
    
    enum Fonts {
        static func enlargedFont(to: CGFloat) -> UIFont { UIFont.systemFont(ofSize: to) }
        static func Marske(size: CGFloat)     -> Font { Font.custom("Marske", size: size) }
        static func DisketMono(size: CGFloat) -> Font { Font.custom("Disket Mono", size: size) }
        static func Cyberpunk(size: CGFloat)  -> Font { Font.custom("Cyberpunk", size: size) }
    }
    
    enum Colors {
        static let text: Color                 = Color.black
        static let background: Color           = Color.white
        static let element: Color              = Color.red
        static let foreground: Color           = Color.white
        static let subScreenButtons: Color     = Color.gray
        static let gradient: [Color]     = [.white, .white]
    }

}
