//
//  GameView.swift
//  TicTacToeApp
//
//  Created by Alexander Vagin on 16.03.2023.
//

import SwiftUI

struct GameView: View {
    
    @EnvironmentObject var gameVM: GameViewModel
    
    var body: some View {
        GeometryReader { geometry in
            
            HeadButtonsView()
                .padding()
            
            VStack {
                Text("ROUND \(gameVM.currentRound)")
                    .font(R.Fonts.Marske(size: 50))
                    .foregroundColor(R.Colors.text)
                Text("FIRST BLOOD")
                    .font(R.Fonts.Cyberpunk(size: 30))
                    .foregroundColor(.brown)
                    .scaleEffect(gameVM.animationAmount)
                    .opacity(!gameVM.winningCells.isEmpty ? gameVM.animationAmount : 0)
                    .animation(.easeInOut(duration: 0.25).delay(0.2), value: gameVM.animationAmount)
                    .padding(.bottom, 20)
                
                GameBoardView(geometry: geometry)
                    .padding(.top, 10)
                
                TurnView()
                    .padding(.top, 50)
                    .padding(.bottom, 20)
                
                WinRatesView()
                    .padding([.leading, .trailing], 20)
                
                AIStatusView()
            }
            .padding(.top, 75)
            
        }
        .navigationBarHidden(true)
        .fullScreenCover(isPresented: $gameVM.showingSheet) {
            WinnerView()
        }
        .alert(gameVM.alertItem?.title ?? Text(""),
               isPresented: $gameVM.showingAlert,
               presenting: gameVM.alertItem,
               actions: { _ in AlertButtonsView() },
               message: { item in item.message })
        .confirmationDialog("Do you want to activate AI?",
                            isPresented: $gameVM.showingActiveAIDialog,
                            titleVisibility: .visible,
                            actions: { AlertButtonsView() },
                            message: { Text("Select AI difficulty") })
    }
}

//struct GameView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameView()
//    }
//}
