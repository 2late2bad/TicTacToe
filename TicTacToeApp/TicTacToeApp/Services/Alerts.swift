//
//  Alerts.swift
//  TicTacToeApp
//
//  Created by Alexander Vagin on 12.06.2023.
//

import SwiftUI

enum AlertType {
    case stopGame
    case disableAI
    case errorSelectedType
}

struct AlertItem: Identifiable {
    let id = UUID()
    let type: AlertType
    
    var title: Text
    var message: Text?
    var buttonTitle1: String?
    var buttonTitle2: String?
}

struct AlertContext {
        
    static let stopGame = AlertItem(type: .stopGame,
                                    title: Text("Leave the match?"),
                                    message: Text("It will reset the game"),
                                    buttonTitle1: "NO",
                                    buttonTitle2: "YES")
    
    static let disableAI = AlertItem(type: .disableAI,
                                     title: Text("Disable AI"),
                                     message: Text("The game will continue with PvP type"),
                                     buttonTitle1: "NO",
                                     buttonTitle2: "YES")
    
    static let errorType = AlertItem(type: .errorSelectedType,
                                     title: Text("You can change the type of game at the turn of the cross"),
                                     buttonTitle1: "OK")
    
}

