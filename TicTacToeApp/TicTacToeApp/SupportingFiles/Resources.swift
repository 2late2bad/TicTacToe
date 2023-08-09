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
        static let creator = "#2late2bad"
        static let version = "0.8"
        static let updated = "08/2023"

        static let easy = "easy_comp".localized
        static let hard = "hard_comp".localized
        static let hell = "hell_comp".localized
        
        static let pvpType = "pvp_type".localized
        static let aiType = "ai_type".localized
        
        static let typeGamePicker   = "Type game"
        static let complexityPicker = "Complexity"
    }
    
    enum Indicators {
        static let rangeOfRounds: ClosedRange = 1...6
        static let resetMoves: [Move?]        = Array(repeating: nil, count: 9)
        
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
            static let positionTurn: (x: CGFloat, y: CGFloat) = (x: 212, y: -68)
        }
        
        enum Circle {
            static let lineWidthDesk: CGFloat  = 11
            static let lineWidthExtra: CGFloat = 2
            static let positionTurn: (x: CGFloat, y: CGFloat) = (x: 240, y: -78)
        }
    }
    
    enum Images {
        static let infoScreenButton: String     = "questionmark.circle"
        static let recordsScreenButton: String  = "trophy"
        static let exitGameButton: String       = "xmark.circle"
        static let muteOnButton: String         = "speaker.slash.fill"
        static let muteOffButton: String        = "speaker"
        static let backStartButtonLeft: String  = "arrow.down.backward"
        static let backStartButtonRight: String = "arrow.down.forward"
    }
    
    enum Fonts {
        static func enlargedFont(to: CGFloat) -> UIFont { UIFont.systemFont(ofSize: to) }
        static func Marske(size: CGFloat)     -> Font { Font.custom("Marske", size: size) }
        static func DisketMono(size: CGFloat) -> Font { Font.custom("Disket Mono", size: size) }
        static func Cyberpunk(size: CGFloat)  -> Font { Font.custom("Cyberpunk", size: size) }
    }
    
    enum Colors {
        static let text: Color                 = Color("Text")
        static let useElement: Color           = Color("UseElement")
        static let element: Color              = Color("Element")
        static let background: Color           = Color("Background")
        static let indicatorDefault: Color     = Color("IndicatorDefault")
        static let indicatorsFlashing: Color   = Color("IndicatorFlashing")
        static let buttonSet: Color            = Color("ButtonSet")
        static let foreground: Color           = Color("Foreground")
        static let recordElement: Color        = Color("RecordElement")
        static let subScreenButtons: Color     = Color.gray
        static let gradient: [Color]           = [.white, .white]
    }
}

