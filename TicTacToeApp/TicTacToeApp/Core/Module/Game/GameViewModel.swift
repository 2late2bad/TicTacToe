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
    
    private let ai: ArtificialIntelligenceProtocol = ArtificialIntelligence.shared
    private var reaction: ReactionServiceProtocol = ReactionService.shared
    private let storage: StorageServiceProtocol = StorageService.shared
    var isCrossTurn: Bool            = true
    var roundLabelRotation: Double   = 360
    var winningCells: [Int]          = []
    var (currentRound, xWins, oWins) = (1, 0, 1)
    
    @Published var moves: [Move?]                 = R.Indicators.resetMoves
    @Published var indicatorColor: Color          = R.Colors.indicatorDefault
    @Published var gridColor: Color               = R.Colors.grid
    @Published var isGameboardDisabled            = true
    @Published var muteSound: Bool                = false {
        willSet {
            reaction.muteSoundEffect = newValue
        }
    }
    @Published var showingSheet: Bool             = false
    @Published var showingAlert: Bool             = false
    @Published var showingActiveAIDialog: Bool    = false
    @Published var selectedComplexity: Complexity = .Easy
    @Published var selectedTypeOfGame: TypeGame   = .PvP {
        willSet {
            if newValue == .PvP {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) { [self] in
                    selectedComplexity = .Easy
                }
            }
        }
    }
    @Published var sumOfWins: Int = 1 { willSet { oWins = newValue } }
    @Published var alertItem: AlertModel?
    @Published var scaleEffect: Double = 0.0
    @Published var textOutcome: String = ""
    @Published var opacityEffect: Double = 0.0
    
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
    
    // Рестарт матча
    func restartMatch() {
        currentRound = 1
        xWins = 0
        oWins = sumOfWins
        moves = R.Indicators.resetMoves
        winningCells = []
        isCrossTurn = true
        
        textOutcome = reaction.startGame()
        reactAnimation(delay: 1)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
            withAnimation {
                isGameboardDisabled = false
            }
        }
    }
    
    // Выход из игры
    func exitGame() {
        isGameboardDisabled = true
    }
}

// MARK: - Private methods
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
    
    // Проверка на победу в матче
    func checkWinMatch(for player: Player?) {
        switch player {
        case .cross:
            winLineAnimation()
            if (xWins + 1) == sumOfWins {
                matchWinner(.cross)
            } else {
                newRound(point: .cross)
            }
        case .zero:
            winLineAnimation()
            if (oWins - 1) == 0 {
                matchWinner(.zero)
            } else {
                newRound(point: .zero)
            }
        default:
            newRound(point: nil)
        }
    }
    
    // Старт нового раунда
    func newRound(point: Player?) {
        switch point {
        case .cross:
            textOutcome = reaction.roundResult(xPoint: xWins + 1, oPoint: oWins, sumOfWins: sumOfWins)
        case .zero:
            textOutcome = reaction.roundResult(xPoint: xWins, oPoint: oWins - 1, sumOfWins: sumOfWins)
        case nil:
            drawAnimation()
            textOutcome = reaction.roundResult(xPoint: 0, oPoint: 0, sumOfWins: 0)
        }
        
        reactAnimation(delay: 0)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
            resetDesk()
            roundLabelAnimation()
            guard let point else { return }
            if point == .cross {
                xWins += 1
            } else {
                oWins -= 1
            }
        }
    }
    
    // Определение победителя в матче
    func matchWinner(_ player: Player) {
        player == .cross ? (xWins += 1) : (oWins -= 1)
        textOutcome = reaction.matchResult(player: player, typeGame: selectedTypeOfGame)
        reactAnimation(delay: 0)
        saveMatch(winner: player)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.05) { [self] in
            withAnimation {
                showingSheet = true
            }
        }
    }
    
    // Сохранение результата матча в хранилище
    func saveMatch(winner: Player) {
        let record = RecordModel(winner: winner,
                                 score: "\(xWins) - \(sumOfWins - oWins)",
                                 type: selectedTypeOfGame,
                                 complexity: selectedComplexity,
                                 date: .now)
        storage.append(object: record, forKey: .records)
    }
    
    // Сброс доски
    func resetDesk() {
        moves = R.Indicators.resetMoves
        winningCells = []
        isCrossTurn = true
        isGameboardDisabled = false
    }
}

// MARK: - Animations
private extension GameViewModel {
    
    // Анимация лейба при новом раунде
    func roundLabelAnimation() {
        roundLabelRotation == 360 ? (roundLabelRotation) = 0 : (roundLabelRotation = 360)
        currentRound += 1
    }
    
    // Анимация сообщения реакции
    func reactAnimation(delay: Double) {
        withAnimation(.easeInOut.delay(delay + 0.1)) {
            opacityEffect = 1
            scaleEffect = 1
        }
        withAnimation(.easeInOut.delay(delay + 1)) {
            opacityEffect = 0
            scaleEffect = 0.1
        }
    }
    
    // Анимация победной линии
    func winLineAnimation() {
        let animation = Animation.easeInOut(duration: 0.1).repeatCount(7, autoreverses: true)
        withAnimation(animation.delay(0.3)) {
            indicatorColor = R.Colors.indicatorsFlashing
        }
        withAnimation(.default.delay(1)) {
            indicatorColor = R.Colors.indicatorDefault
        }
    }
    
    // Анимация доски в случае ничьи
    func drawAnimation() {
        let animation = Animation.easeInOut(duration: 0.1).repeatCount(6, autoreverses: true)
        withAnimation(animation.delay(0.2)) {
            gridColor = R.Colors.indicatorsFlashing.opacity(1)
        }
        withAnimation(.easeInOut(duration: 0.1).delay(0.8)) {
            gridColor = R.Colors.grid
        }
    }
}
