//
//  AIStatusView.swift
//  TicTacToeApp
//
//  Created by Alexander Vagin on 14.06.2023.
//

import SwiftUI

struct AIStatusView: View {
    
    @EnvironmentObject var gameVM: GameViewModel
    
    var body: some View {
        Text("\("ai_status".localized): \(gameVM.selectedTypeOfGame == .PvP ? "ai_disabled".localized : gameVM.selectedComplexity.title)")
            .font(R.Fonts.DisketMono(size: 10))
            .foregroundColor(R.Colors.text.opacity(0.8))
            .onTapGesture {
                if gameVM.isCrossTurn {
                    if gameVM.selectedTypeOfGame == .AI {
                        gameVM.alertItem = AlertContext.disableAI
                        gameVM.showingAlert = true
                    } else {
                        gameVM.showingActiveAIDialog = true
                    }
                } else {
                    gameVM.alertItem = AlertContext.errorType
                    gameVM.showingAlert = true
                }
            }
    }
}

