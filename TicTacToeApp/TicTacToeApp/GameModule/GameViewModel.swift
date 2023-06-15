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
    
    @Published var alertItem: AlertModel?
    @Published var isGameboardDisabled            = false
    @Published var moves: [Move?]                 = R.Indicators.resetMoves
    @Published var flashingColor: Color           = R.Colors.indicators
    @Published var gridOpacity: Double            = R.Indicators.Grid.opacity
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
    @Published var sumOfWins: Int = 1 {
        willSet {
            oWins = newValue
        }
    }

    let ai: ArtificialIntelligenceProtocol = ArtificialIntelligence()
    var isCrossTurn                   = true
    var textOutcome: String           = "FIGHT!"
    var showingOutcome: Bool          = false
    var roundLabelRotation: Double    = 360
    var indicatorCrossPosition        = R.Indicators.Cross.positionTurn
    var indicatorZeroPosition         = R.Indicators.Circle.positionTurn
    var indicatorCrossOpacity: Double = 0
    var indicatorZeroOpacity: Double  = 0
    var winningCells: [Int]           = []
    var currentRound: Int             = 1
    var xWins: Int                    = 0
    var oWins: Int                    = 1

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

    // Рестарт раунда (либо всего матча)
    func restartRound(match: Bool) {
        moves = R.Indicators.resetMoves
        winningCells = []
        isCrossTurn = true
        isGameboardDisabled = false
        if match {
            indicatorCrossPosition = (x: 212, y: -68)
            indicatorZeroPosition = (x: 240, y: -78)
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
                winRateAnimation(.cross)
                restartBoard(point: .cross)
            }
        case .zero:
            winLineAnimation()
            if (oWins - 1) == 0 {
                matchWinner(.zero)
            } else {
                winRateAnimation(.zero)
                restartBoard(point: .zero)
            }
        default:
            drawAnimation()
            restartBoard(point: nil)
        }
    }
    
    // Обновление игрового поля для следующего раунда
    func restartBoard(point: Player?) {
        switch point {
        case .cross:
            generationResultRound(xWins + 1)
        case .zero:
            generationResultRound(sumOfWins - oWins + 1)
        case nil:
            generationResultRound(10)
        }
        
        showingOutcome = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
            restartRound(match: false)
            if point != nil {
                point == .cross ? (xWins += 1) : (oWins -= 1)
            }
        }
    }
    
    // Определение победителя в матче
    func matchWinner(_ player: Player) {
        player == .cross ? (xWins += 1) : (oWins -= 1)
        generationResultRound(0)
        showingOutcome = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
            showingOutcome = false
            showingSheet = true
        }
    }
    
    // Генерация текста результата раунда
    func generationResultRound(_ count: Int) {
        switch count {
        case 0:
            textOutcome = "WIN"
        case 1:
            textOutcome = "FIRST BLOOD"
        case 2:
            textOutcome = "DOUBLE KILL"
        case 3:
            textOutcome = "TRIPLE KILL"
        case 4:
            textOutcome = "DOMINATING"
        case 5:
            textOutcome = "RAMPAGE"
        default:
            textOutcome = "DRAW"
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
        let animation = Animation.linear(duration: 0.07).repeatCount(5, autoreverses: true)
        withAnimation(animation.delay(0.3)) {
            flashingColor = R.Colors.element
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.65) { [self] in
            withAnimation(animation) {
                flashingColor = R.Colors.indicators
            }
        }
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
