//
//  ReactionService.swift
//  TicTacToeApp
//
//  Created by Alexander Vagin on 15.06.2023.
//

import Foundation

protocol ReactionServiceProtocol {
    // Генерация результата раунда
    func roundResult(xPoint: Int, oPoint: Int, sumOfWins: Int) -> String
    // Генерация результата матча
    func matchResult(player: Player, typeGame: TypeGame) -> String
}

final class ReactionService {
    
}

extension ReactionService: ReactionServiceProtocol {
    
    func matchResult(player: Player, typeGame: TypeGame) -> String {
        switch typeGame {
        case .PvP:
            return player == .cross ? "CROSS    WINNER" : "ZERO    WINNER"
        case .AI:
            return player == .cross ? "YOU  ARE  WINNER" : "YOU   SUCK"
        }
    }
    
    func roundResult(xPoint: Int, oPoint: Int, sumOfWins: Int) -> String {
        // Проверка на ничью
        guard sumOfWins != 0 else { return "DRAW" }
        
        // Генерация реакции в зависимости от счета в игре
        switch (xPoint, oPoint, sumOfWins) {
            // Условие first blood (1-0 or 0-1)
        case let (xP , oP, sumP) where ((sumP - oP == 1) && (xP == 0)) || ((sumP - oP == 0) && (xP == 1)):
            SoundManager.instance.playSound(.firstblood)
            return "FIRST  BLOOD"
            
            // Условие nice catch (1-1, 2-2, 3-3, 4-4, 5-5)
        case let (xP , oP, sumP) where (xP == sumP - oP):
            return "NICE  CATCH"
            
            // Условие dominating (2-0 or 0-2)
        case let (xP , oP, sumP) where ((sumP - oP == 2) && (xP == 0)) || ((sumP - oP == 0) && (xP == 2)):
            return "DOMINATING"
            
            // Условие unstoppable (3-0 or 0-3)
        case let (xP , oP, sumP) where ((sumP - oP == 3) && (xP == 0)) || ((sumP - oP == 0) && (xP == 3)):
            return "UNSTOPPABLE"
            
            // Условие wicked sick (4-0 or 0-4)
        case let (xP , oP, sumP) where ((sumP - oP == 4) && (xP == 0)) || ((sumP - oP == 0) && (xP == 4)):
            return "WICKED   SICK"
            
            // Условие godlike (5-0 or 0-5)
        case let (xP , oP, sumP) where ((sumP - oP == 5) && (xP == 0)) || ((sumP - oP == 0) && (xP == 5)):
            return "GODLIKE"
            
            // Условие rampage (5-1 or 1-5)
        case let (xP , oP, sumP) where ((sumP - oP == 5) && (xP == 1)) || ((sumP - oP == 1) && (xP == 5)):
            return "RAMPAGE"
            
            // Условие ownage (4-1, 1-4, 5-2, 2-5)
        case let (xP , oP, sumP) where
            ((sumP - oP == 4) && (xP == 1))
            || ((sumP - oP == 1) && (xP == 4))
            || ((sumP - oP == 5) && (xP == 2))
            || ((sumP - oP == 2) && (xP == 5)):
            return "OWNAGE"
            
            // Условие holy shit (3-1, 1-3, 4-2, 2-4, 5-3, 3-5)
        case let (xP , oP, sumP) where
            ((sumP - oP == 3) && (xP == 1))
            || ((sumP - oP == 1) && (xP == 3))
            || ((sumP - oP == 4) && (xP == 2))
            || ((sumP - oP == 2) && (xP == 4))
            || ((sumP - oP == 5) && (xP == 3))
            || ((sumP - oP == 3) && (xP == 5)):
            return "HOLY   SHIT"
            
            // Условие combo whore (3-2, 2-3, 4-3, 3-4, 5-4, 4-5)
        case let (xP , oP, sumP) where
            ((sumP - oP == 3) && (xP == 2))
            || ((sumP - oP == 2) && (xP == 3))
            || ((sumP - oP == 4) && (xP == 3))
            || ((sumP - oP == 3) && (xP == 4))
            || ((sumP - oP == 5) && (xP == 4))
            || ((sumP - oP == 4) && (xP == 5)):
            return "COMBO    WHORE"
            
            // Условие toasty (2-1 or 1-2)
        case let (xP , oP, sumP) where ((sumP - oP == 2) && (xP == 1)) || ((sumP - oP == 1) && (xP == 2)):
            return "TOASTY"
            
        default: return ""
        }
    }
}
