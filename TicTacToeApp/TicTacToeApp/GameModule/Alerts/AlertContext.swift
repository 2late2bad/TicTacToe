//
//  AlertContext.swift
//  TicTacToeApp
//
//  Created by Alexander Vagin on 14.06.2023.
//

import SwiftUI

struct AlertContext {
        
    static let stopGame = AlertModel(type: .stopGame,
                                    title: Text("Leave the match?"),
                                    message: Text("It will reset the game"),
                                    buttonTitle1: "NO",
                                    buttonTitle2: "YES")
    
    static let disableAI = AlertModel(type: .disableAI,
                                     title: Text("Disable AI"),
                                     message: Text("The game will continue with PvP type"),
                                     buttonTitle1: "NO",
                                     buttonTitle2: "YES")
    
    static let errorType = AlertModel(type: .errorSelectedType,
                                     title: Text("You can change the type of game at the turn of the cross"),
                                     buttonTitle1: "OK")
    
}
