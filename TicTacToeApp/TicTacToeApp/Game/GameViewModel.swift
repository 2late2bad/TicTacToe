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
    
    @Published var moves: [Move?]                 = R.Indicators.resetMoves
    @Published var indicatorColor: Color          = R.Colors.indicatorDefault
    @Published var gridOpacity: Double            = R.Indicators.Grid.opacity
    @Published var isGameboardDisabled            = false
    @Published var muteSound: Bool                = false
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
    
    let ai: ArtificialIntelligenceProtocol = ArtificialIntelligence()
    let reaction: ReactionServiceProtocol  = ReactionService()
    var (isCrossTurn, showingOutcome)                 = (true, false)
    var textOutcome: String                           = "FIGHT!"
    var roundLabelRotation: Double                    = 360
    var indicatorCrossPosition                        = R.Indicators.Cross.positionTurn
    var indicatorZeroPosition                         = R.Indicators.Circle.positionTurn
    var winningCells: [Int]                           = []
    var (indicatorCrossOpacity, indicatorZeroOpacity) = (0.0, 0.0)
    var (currentRound, xWins, oWins)                  = (1, 0, 1)
    
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
    
    // Старт следующего раунда (либо рестарт матча)
    func newRound(andMatch: Bool) {
        moves = R.Indicators.resetMoves
        winningCells = []
        isCrossTurn = true
        isGameboardDisabled = false
        if andMatch {
            indicatorCrossPosition = R.Indicators.Cross.positionTurn
            indicatorZeroPosition = R.Indicators.Circle.positionTurn
            currentRound = 1
            xWins = 0
            oWins = sumOfWins
        } else {
            reloadAnimation()
            currentRound += 1
            indicatorCrossOpacity = 0
            indicatorZeroOpacity = 0
            showingOutcome = false
        }
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
                endRound(point: .cross)
            }
        case .zero:
            winLineAnimation()
            if (oWins - 1) == 0 {
                matchWinner(.zero)
            } else {
                endRound(point: .zero)
            }
        default:
            endRound(point: nil)
        }
    }
    
    // Подведение итогов раунда
    func endRound(point: Player?) {
        switch point {
        case .cross:
            winRateAnimation(.cross)
            textOutcome = reaction.roundResult(xPoint: xWins + 1, oPoint: oWins, sumOfWins: sumOfWins)
        case .zero:
            winRateAnimation(.zero)
            textOutcome = reaction.roundResult(xPoint: xWins, oPoint: oWins - 1, sumOfWins: sumOfWins)
        case nil:
            drawAnimation()
            textOutcome = reaction.roundResult(xPoint: 0, oPoint: 0, sumOfWins: 0)
        }
        
        showingOutcome = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
            newRound(andMatch: false)
            if point != nil {
                point == .cross ? (xWins += 1) : (oWins -= 1)
            }
        }
    }
    
    // Определение победителя в матче
    func matchWinner(_ player: Player) {
        player == .cross ? (xWins += 1) : (oWins -= 1)
        textOutcome = reaction.matchResult(player: player, typeGame: selectedTypeOfGame)
        showingOutcome = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
            showingOutcome = false
            withAnimation {
                showingSheet = true
            }
        }
    }
}

// MARK: - Animations
private extension GameViewModel {
    
    // Анимация добавления индикатора игрока в его пул побед
    func winRateAnimation(_ player: Player) {
        switch player {
        case .cross:
            indicatorCrossOpacity = 1
            if xWins == 0 {
                indicatorCrossPosition = (x: 10, y: -18)
            } else {
                indicatorCrossPosition.x += 28
            }
        case .zero:
            indicatorZeroOpacity = 1
            if (sumOfWins - oWins) == 0 {
                indicatorZeroPosition = (x: 364, y: -28)
            } else {
                indicatorZeroPosition.x -= 28
            }
        }
    }
    
    // Анимация элементов при смене раунда
    func reloadAnimation() {
        roundLabelRotation == 360 ? (roundLabelRotation) = 0 : (roundLabelRotation = 360)
    }
    
    // Анимация победной линии
    func winLineAnimation() {
        let animation = Animation.easeIn(duration: 0.07).repeatCount(5, autoreverses: true)
        withAnimation(animation.delay(0.3)) {
            indicatorColor = R.Colors.indicatorsFlashing
        }
        withAnimation(animation.delay(0.65)) {
            indicatorColor = R.Colors.indicatorDefault
        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.65) { [self] in
//            withAnimation(animation) {
//                indicatorColor = R.Colors.indicatorDefault
//            }
//        }
    }
    
    // Анимация доски в случае ничьи
    func drawAnimation() {
        let animation = Animation.easeInOut(duration: 0.08).repeatCount(5, autoreverses: true)
        withAnimation(animation.delay(0.2)) {
            gridOpacity = 1
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) { [self] in
            withAnimation(animation) {
                gridOpacity = R.Indicators.Grid.opacity
            }
        }
    }
}
