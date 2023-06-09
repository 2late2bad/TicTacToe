//
//  GameModel.swift
//  TicTacToeApp
//
//  Created by Alexander Vagin on 16.03.2023.
//

import Foundation

enum Player: String {
    case cross = "Cross"
    case zero = "Zero"
}

struct Move {
    let player: Player
    let boardIndex: Int
}
