//
//  GameViewModel.swift
//  TicTacToeApp
//
//  Created by Alexander Vagin on 16.03.2023.
//

import SwiftUI

final class GameViewModel: ObservableObject {
    
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible())]
    
    @Published var isGameboardDisabled = false
    var moves: [Move?] = Array(repeating: nil, count: 9)
    var isCrossTurn = true
    
    func processPlayerMove(for position: Int) {
        if isCellNotEmpty(in: moves, for: position) { return }
        moves[position] = Move(player: isCrossTurn ? .cross : .zero, boardIndex: position)
        isCrossTurn.toggle()
        isGameboardDisabled = true
        
        if checkWinCondition(for: .cross, in: moves) {
            print("Крестик победил!")
            return
        }
        
        if checkWinCondition(for: .zero, in: moves) {
            print("Нолик победил!")
            return
        }
        
        if checkForDraw(in: moves) {
            print("Ничья")
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [self] in
            isGameboardDisabled = false
        }
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) { [self] in
//            /// integration AI
//            isGameboardDisabled = false
//            if checkWinCondition(for: .zero, in: moves) {
//                print("Нолик победил!")
//                return
//            }
//            if checkForDraw(in: moves) {
//                print("Ничья")
//                return
//            }
//        }
    }
    
    // Проверка, занята ли ячейка
    func isCellNotEmpty(in moves: [Move?], for index: Int) -> Bool {
        moves.contains(where: { $0?.boardIndex == index })
    }
    // Проверка на победу игрока
    func checkWinCondition(for player: Player, in moves: [Move?]) -> Bool {
        let winPatterns: Set<Set<Int>> = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
        
        let allPlayerMoves = moves.compactMap { $0 }.filter { $0.player == player }
        let playerPosition = Set(allPlayerMoves.map { $0.boardIndex })
        
        for pattern in winPatterns where pattern.isSubset(of: playerPosition) { return true }
        return false
    }
    // Проверка на ничью
    func checkForDraw(in moves: [Move?]) -> Bool {
        moves.compactMap { $0 }.count == 9
    }
    
}
