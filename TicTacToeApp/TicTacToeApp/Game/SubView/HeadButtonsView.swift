//
//  HeadButtonsView.swift
//  TicTacToeApp
//
//  Created by Alexander Vagin on 14.06.2023.
//

import SwiftUI

struct HeadButtonsView: View {
    
    @EnvironmentObject var gameVM: GameViewModel
    
    var body: some View {
        HStack {
            Button {
                gameVM.alertItem = AlertContext.stopGame
                gameVM.showingAlert = true
            } label: {
                Image(systemName: R.Images.exitGameButton)
                    .imageScale(.large)
                    .foregroundColor(R.Colors.buttonSet)
            }
            Spacer()
            Button {
                gameVM.muteSound.toggle()
            } label: {
                Image(systemName: gameVM.muteSound ? R.Images.muteOnButton : R.Images.muteOffButton)
                    .imageScale(.large)
                    .foregroundColor(gameVM.muteSound ? R.Colors.indicatorsFlashing.opacity(0.8) : R.Colors.buttonSet)
            }
        }
    }
}
