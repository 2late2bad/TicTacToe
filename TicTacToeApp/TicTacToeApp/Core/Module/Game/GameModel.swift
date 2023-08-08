//
//  GameModel.swift
//  TicTacToeApp
//
//  Created by Alexander Vagin on 16.03.2023.
//

import Foundation

enum Player: String, Codable {
    case cross = "Cross"
    case zero = "Zero"
}

struct Move {
    let player: Player
    let boardIndex: Int
}
