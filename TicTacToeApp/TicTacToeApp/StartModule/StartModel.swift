//
//  StartModel.swift
//  TicTacToeApp
//
//  Created by Alexander Vagin on 21.03.2023.
//

import Foundation

enum Complexity: String, CaseIterable, Identifiable {
    case Easy
    case Hard
    case HELL
    
    var id: Self {
        self
    }
    
    var title: String {
        switch self {
        case .Easy:
            return "🤡"
        case .Hard:
            return "👺"
        case .HELL:
            return "🗿"
        }
    }
}

enum TypeGame: String, CaseIterable, Identifiable {
    case PvP
    case AI
    
    var id: Self {
        self
    }
}
