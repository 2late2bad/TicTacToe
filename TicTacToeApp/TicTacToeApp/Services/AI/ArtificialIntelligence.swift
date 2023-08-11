//
//  ArtificialIntelligence.swift
//  TicTacToeApp
//
//  Created by Alexander Vagin on 12.06.2023.
//

import Foundation

protocol ArtificialIntelligenceProtocol {
    // AI work
    func determineComputerMovePosition(in moves: [Move?], difficalty: Complexity) -> Int
}

final class ArtificialIntelligence {
    static let shared = ArtificialIntelligence()
    private init() {}
    // Helper
    private func isCellNotEmpty(in moves: [Move?], for index: Int) -> Bool {
        moves.contains(where: { $0?.boardIndex == index })
    }
}

extension ArtificialIntelligence: ArtificialIntelligenceProtocol {
    
    func determineComputerMovePosition(in moves: [Move?], difficalty: Complexity) -> Int {
        
        // Tier 3 - Если возможна победа ходом, сделай этот ход
        let winPatterns: Set<Set<Int>> = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
        
        let computerMoves = moves.compactMap { $0 }.filter { $0.player == .zero }
        let computerPositions = Set(computerMoves.map { $0.boardIndex })
        
        for pattern in winPatterns {
            let winPositions = pattern.subtracting(computerPositions)
            
            if winPositions.count == 1 {
                let isAvaiable = !isCellNotEmpty(in: moves, for: winPositions.first!)
                if isAvaiable {
                    if difficalty == .Easy {
                        if Bool.random() { return winPositions.first! }
                    } else {
                        return winPositions.first!
                    }
                }
            }
        }
        
        // Tier 2 - Если не можешь победить ходом, заблокируй ход противника
        let humanMoves = moves.compactMap { $0 }.filter { $0.player == .cross }
        let humanPositions = Set(humanMoves.map { $0.boardIndex })
        
        for pattern in winPatterns {
            let winPositions = pattern.subtracting(humanPositions)
            
            if winPositions.count == 1 {
                let isAvaiable = !isCellNotEmpty(in: moves, for: winPositions.first!)
                if isAvaiable {
                    switch difficalty {
                    case .Easy:
                        if Bool.random() { return winPositions.first! }
                    case .Hard:
                        if Int.random(in: 1...10) < 9 { return winPositions.first! }
                    case .HELL:
                        return winPositions.first!
                    }
                }
            }
        }
        
        // Tier 1 - Если не можешь блокировать, забери центральный квадрат
        let centerSquare = 4
        if !isCellNotEmpty(in: moves, for: centerSquare) {
            switch difficalty {
            case .Easy:
                break
            case .Hard:
                if Bool.random() { return centerSquare }
            case .HELL:
                return centerSquare
            }
        }
        
        // Выбор рандомной позиции (если ни один Tier не дал результат)
        var movePosition = Int.random(in: 0..<9)
        
        while isCellNotEmpty(in: moves, for: movePosition) {
            movePosition = Int.random(in: 0..<9)
        }
        
        return movePosition
    }
    
}
