//
//  StartModel.swift
//  TicTacToeApp
//
//  Created by Alexander Vagin on 21.03.2023.
//

import Foundation

enum Complexity: String, CaseIterable, Identifiable, Codable {
    case Easy
    case Hard
    case HELL
    
    var id: Self {
        self
    }
    
    var title: String {
        switch self {
        case .Easy:
            return R.Strings.easy
        case .Hard:
            return R.Strings.hard
        case .HELL:
            return R.Strings.hell
        }
    }
}

enum TypeGame: String, CaseIterable, Identifiable, Codable {
    case PvP
    case AI
    
    var id: Self {
        self
    }
    
    var title: String {
        switch self {
        case .PvP:
            return R.Strings.pvpType
        case .AI:
            return R.Strings.aiType
        }
    }
}
