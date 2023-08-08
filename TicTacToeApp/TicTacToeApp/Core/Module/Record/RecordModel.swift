//
//  RecordModel.swift
//  TicTacToeApp
//
//  Created by Alexander Vagin on 08.08.2023.
//

import Foundation

struct RecordModel: Identifiable {
    let id = UUID()
    let player: Player
    let score: String
    let type: TypeGame
    let date: Date
    
    static func getTest() -> [RecordModel] {
        [
            RecordModel(player: .cross, score: "3 - 1", type: .PvP, date: .now),
            RecordModel(player: .zero, score: "0 - 2", type: .AI, date: .now),
            RecordModel(player: .cross, score: "5 - 4", type: .AI, date: .now),
            RecordModel(player: .zero, score: "2 - 3", type: .PvP, date: .now),
            RecordModel(player: .cross, score: "1 - 0", type: .AI, date: .now),
            RecordModel(player: .cross, score: "3 - 1", type: .PvP, date: .now),
            RecordModel(player: .zero, score: "0 - 2", type: .AI, date: .now),
            RecordModel(player: .cross, score: "5 - 4", type: .AI, date: .now),
            RecordModel(player: .zero, score: "2 - 3", type: .PvP, date: .now),
            RecordModel(player: .cross, score: "1 - 0", type: .AI, date: .now),
            RecordModel(player: .cross, score: "3 - 1", type: .PvP, date: .now),
            RecordModel(player: .zero, score: "0 - 2", type: .AI, date: .now),
            RecordModel(player: .cross, score: "5 - 4", type: .AI, date: .now),
            RecordModel(player: .zero, score: "2 - 3", type: .PvP, date: .now),
            RecordModel(player: .cross, score: "1 - 0", type: .AI, date: .now),
            RecordModel(player: .cross, score: "3 - 1", type: .PvP, date: .now),
            RecordModel(player: .zero, score: "0 - 2", type: .AI, date: .now),
            RecordModel(player: .cross, score: "5 - 4", type: .AI, date: .now),
            RecordModel(player: .zero, score: "2 - 3", type: .PvP, date: .now),
            RecordModel(player: .cross, score: "1 - 0", type: .AI, date: .now)
        ]
    }
}
