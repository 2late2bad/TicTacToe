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
        static let easy = "🤡 Easy"
        static let hard = "👺 Hard"
        static let hell = "🗿 HELL"
        
        static let typeGamePicker   = "Type game"
        static let complexityPicker = "Complexity"
    }
    
    enum Indicators {
        static let rangeOfRounds: ClosedRange = 1...6
        
        enum Grid {
            static let indentLines: CGFloat  = 16
            static let thickness: CGFloat    = 2
            static let opacity: Double       = 0.2
            static let animDuration: Double  = 0.8
        }
        
        enum Cross {
            static let angleForce: CGFloat = 0.12
            static let lenght: CGFloat     = 82
            static let thickness: CGFloat  = 12
        }
        
        enum Circle {
            static let lineWidthDesk: CGFloat  = 11
            static let lineWidthExtra: CGFloat = 2
        }
    }
    
    enum Images {
        static let infoScreenButton: String     = "questionmark.circle"
        static let settingsScreenButton: String = "gearshape"
        static let exitGameButton: String       = "xmark.circle"
        static let muteOnButton: String         = "speaker.slash.fill"
        static let muteOffButton: String        = "speaker"
    }
    
    enum Fonts {
        static func enlargedFont(to: CGFloat) -> UIFont { UIFont.systemFont(ofSize: to) }
        static func Marske(size: CGFloat)     -> Font { Font.custom("Marske", size: size) }
        static func DisketMono(size: CGFloat) -> Font { Font.custom("Disket Mono", size: size) }
        static func Cyberpunk(size: CGFloat)  -> Font { Font.custom("Cyberpunk", size: size) }
    }
    
    enum Colors {
        static let text: Color                 = Color.black
        static let indicators: Color           = Color.black
        static let background: Color           = Color("background")
        static let element: Color              = Color.red
        static let foreground: Color           = Color.white
        static let subScreenButtons: Color     = Color.gray
        static let gradient: [Color]           = [.white, .white]
    }

}
