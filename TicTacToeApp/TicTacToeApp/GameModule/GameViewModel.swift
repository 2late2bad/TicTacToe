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
    
    @Published var alertItem: AlertItem?
    @Published var isGameboardDisabled            = false
    @Published var moves: [Move?]                 = Array(repeating: nil, count: 9)
    @Published var selectedTypeOfGame: TypeGame   = .PvP {
        willSet {
            if newValue == .PvP {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) { [self] in
                    selectedComplexity = .Easy
                }
            }
        }
    }
    @Published var selectedComplexity: Complexity = .Easy
    @Published var sumOfWins: Int = 1 {
        willSet {
            oWins = newValue
        }
    }
    
    @Published var flashingColor: Color        = .black
    @Published var animationAmount: Double     = 0.001
    @Published var muteSound: Bool             = false
    @Published var showingSheet: Bool          = false
    @Published var showingAlert: Bool          = false
    @Published var showingActiveAIDialog: Bool = false
    
    let ai: ArtificialIntelligenceProtocol = ArtificialIntelligence()
    var isCrossTurn = true
    var winningCells: [Int] = []
    var currentRound: Int = 1
    var xWins: Int = 0
    var oWins: Int = 1

    // Ход игрока/AI
    func processPlayerMove(for position: Int) {
        if isCellNotEmpty(in: moves, for: position) { return }
        moves[position] = Move(player: isCrossTurn ? .cross : .zero, boardIndex: position)
        isGameboardDisabled = true
        
        if checkWinCondition(for: .cross, in: moves) {
            checkWinMatch(for: .cross)
            return
        }
        
        if checkWinCondition(for: .zero, in: moves) && selectedTypeOfGame == .PvP {
            checkWinMatch(for: .zero)
            return
        }
        
        if checkForDraw(in: moves) {
            checkWinMatch(for: nil)
            return
        }
        
        isCrossTurn.toggle()
        
        switch selectedTypeOfGame {
        case .PvP:
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [self] in
                isGameboardDisabled = false
            }
        case .AI:
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) { [self] in
                let computerPosition = ai.determineComputerMovePosition(in: moves, difficalty: selectedComplexity)
                moves[computerPosition] = Move(player: isCrossTurn ? .cross : .zero, boardIndex: computerPosition)
                
                if checkWinCondition(for: .zero, in: moves) {
                    checkWinMatch(for: .zero)
                    return
                }
                
                if checkForDraw(in: moves) {
                    checkWinMatch(for: nil)
                    return
                }
                
                isCrossTurn.toggle()
                isGameboardDisabled = false
            }
        }
        
    }

    // Рестарт игры
    func restartGame() {
        moves = Array(repeating: nil, count: 9)
        winningCells = []
        isCrossTurn = true
        isGameboardDisabled = false
        currentRound = 1
        xWins = 0
        oWins = sumOfWins
    }
    
}

private extension GameViewModel {
    
    // Проверка, занята ли ячейка
    func isCellNotEmpty(in moves: [Move?], for index: Int) -> Bool {
        moves.contains(where: { $0?.boardIndex == index })
    }
    
    // Проверка на победу игрока в раунде
    func checkWinCondition(for player: Player, in moves: [Move?]) -> Bool {
        let winPatterns: Set<Set<Int>> = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
        
        let allPlayerMoves = moves.compactMap { $0 }.filter { $0.player == player }
        let playerPosition = Set(allPlayerMoves.map { $0.boardIndex })
        
        for pattern in winPatterns where pattern.isSubset(of: playerPosition) {
            pattern.forEach { winningCells.append($0) }
            return true
        }
        return false
    }
    
    // Проверка на ничью в раунде
    func checkForDraw(in moves: [Move?]) -> Bool {
        moves.compactMap { $0 }.count == 9
    }
    
    // Рестарт раунда
    func restartBoard(point: Player?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
            moves = Array(repeating: nil, count: 9)
            winningCells = []
            isCrossTurn = true
            isGameboardDisabled = false
            currentRound += 1
            if point != nil {
                point == .cross ? (xWins += 1) : (oWins -= 1)
            }
        }
    }
    
    // Проверка на победу в матче
    func checkWinMatch(for player: Player?) {
        switch player {
        case .cross:
            if (xWins + 1) == sumOfWins {
                xWins += 1
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
                    showingSheet = true
                }
            } else {
                restartBoard(point: .cross)
            }
        case .zero:
            if (oWins - 1) == 0 {
                oWins -= 1
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
                    showingSheet = true
                }
            } else {
                restartBoard(point: .zero)
            }
        default:
            restartBoard(point: nil)
        }
    }
    
}
