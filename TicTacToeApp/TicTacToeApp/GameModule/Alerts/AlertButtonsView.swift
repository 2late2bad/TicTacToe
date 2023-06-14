//
//  AlertButtonsView.swift
//  TicTacToeApp
//
//  Created by Alexander Vagin on 14.06.2023.
//

import SwiftUI

struct AlertButtonsView: View {
    
    @EnvironmentObject var gameVM: GameViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        if gameVM.showingAlert {
            switch gameVM.alertItem!.type {
            case .stopGame:
                Button(gameVM.alertItem!.buttonTitle1!, role: .cancel) {}
                Button(gameVM.alertItem!.buttonTitle2!, role: .destructive) {
                    gameVM.restartGame()
                    gameVM.selectedTypeOfGame = .PvP
                    dismiss()
                }
            case .disableAI:
                Button(gameVM.alertItem!.buttonTitle1!, role: .cancel) {}
                Button(gameVM.alertItem!.buttonTitle2!, role: .destructive) {
                    gameVM.selectedTypeOfGame = .PvP
                }
            case .errorSelectedType:
                Button(gameVM.alertItem!.buttonTitle1!, role: .cancel) {}
            }
        }
        
        if gameVM.showingActiveAIDialog {
            Button(R.Strings.easy, role: .destructive) {
                gameVM.selectedComplexity = .Easy
                gameVM.selectedTypeOfGame = .AI
            }
            Button(R.Strings.hard, role: .destructive) {
                gameVM.selectedComplexity = .Hard
                gameVM.selectedTypeOfGame = .AI
            }
            Button(R.Strings.hell, role: .destructive) {
                gameVM.selectedComplexity = .HELL
                gameVM.selectedTypeOfGame = .AI
            }
        }
        
    }
}
