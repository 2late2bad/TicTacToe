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
            
            ZStack(alignment: .top) {
                VStack() {
                    if gameVM.showingOutcome {
                        Text(gameVM.textOutcome)
                            .font(R.Fonts.Cyberpunk(size: 30))
                            .foregroundColor(.brown)
                            .transition(.scale)
                            .padding(.bottom, 20)
                    }
                }
                .offset(y: 130)
                .padding(.bottom, 20)
                .animation(.easeInOut(duration: 0.3),
                           value: gameVM.showingOutcome)
                
                VStack {
                    Text("ROUND \(gameVM.currentRound)")
                        .font(R.Fonts.Marske(size: 50))
                        .foregroundColor(R.Colors.text)
                        .rotation3DEffect(.degrees(gameVM.roundLabelRotation), axis: (x: 1, y: 0, z: 0))
                        .animation(.spring(dampingFraction: 0.7), value: gameVM.roundLabelRotation)
                    
                    GameBoardView(geometry: geometry)
                        .padding(.top, 40)
                    
                    TurnView()
                        .padding(.top, 60)
                        .padding(.bottom, 20)
                    
                    WinRatesView()
                        .padding([.leading, .trailing], 20)
                    
                    AIStatusView()
                        .padding(.top, 5)
                }
                .padding(.top, 80)
            }
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
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                gameVM.newRound(andMatch: true)
            }
        }
    }
}
