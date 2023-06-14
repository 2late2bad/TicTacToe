//
//  AlertModel.swift
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

struct AlertModel: Identifiable {
    let id = UUID()
    let type: AlertType
    
    var title: Text
    var message: Text?
    var buttonTitle1: String?
    var buttonTitle2: String?
}
