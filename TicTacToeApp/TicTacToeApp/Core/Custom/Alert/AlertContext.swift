//
//  AlertContext.swift
//  TicTacToeApp
//
//  Created by Alexander Vagin on 14.06.2023.
//

import SwiftUI

struct AlertContext {
    
    static let stopGame = AlertModel(type: .stopGame,
                                     title: Text("stop_game_title".localized),
                                     message: Text("stop_game_message".localized),
                                     buttonTitle1: "button_no".localized,
                                     buttonTitle2: "button_yes".localized)
    
    static let disableAI = AlertModel(type: .disableAI,
                                      title: Text("disable_ai_title".localized),
                                      message: Text("disable_ai_message".localized),
                                      buttonTitle1: "button_no".localized,
                                      buttonTitle2: "button_yes".localized)
    
    static let errorType = AlertModel(type: .errorSelectedType,
                                      title: Text("error_selected_title".localized),
                                      buttonTitle1: "button_ok".localized)
}
