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
            return R.Strings.easyDifficalty
        case .Hard:
            return R.Strings.hardDifficalty
        case .HELL:
            return R.Strings.hellDifficalty
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
