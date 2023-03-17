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
    
    @Published var moves: [Move?] = Array(repeating: nil, count: 9)
    @Published var isCrossTurn = true
    
    func processPlayerMove(for position: Int) {
        if isCellEmpty(in: moves, for: position) { return }
        moves[position] = Move(player: isCrossTurn ? .cross : .zero, boardIndex: position)
        isCrossTurn.toggle()
    }
    
    func isCellEmpty(in moves: [Move?], for index: Int) -> Bool {
        moves.contains(where: { $0?.boardIndex == index })
    }
    
}
