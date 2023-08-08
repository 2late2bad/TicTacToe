//
//  RecordModel.swift
//  TicTacToeApp
//
//  Created by Alexander Vagin on 08.08.2023.
//

import Foundation

struct RecordModel: Identifiable, Codable {
    var id = UUID()
    let winner: Player
    let score: String
    let type: TypeGame
    let date: Date
}
