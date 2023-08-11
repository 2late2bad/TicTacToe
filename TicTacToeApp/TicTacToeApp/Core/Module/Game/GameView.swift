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
            ZStack(alignment: .center) {
                R.Colors.background
                    .ignoresSafeArea()
                
                VStack(alignment: .center, spacing: 0) {
                    HeadButtonsView()
                        .padding(.horizontal)
                        .padding(.bottom, 20)
                    
                    Text("\("round".localized) \(gameVM.currentRound)")
                        .font(R.Fonts.Marske(size: 50))
                        .lineLimit(1)
                        .foregroundColor(R.Colors.text)
                        .rotation3DEffect(.degrees(gameVM.roundLabelRotation), axis: (x: 1, y: 0, z: 0))
                        .animation(.spring(dampingFraction: 0.7), value: gameVM.roundLabelRotation)
                    
                    Text(gameVM.textOutcome)
                        .frame(height: 40)
                        .font(R.Fonts.Cyberpunk(size: 30))
                        .lineLimit(1)
                        .minimumScaleFactor(0.9)
                        .foregroundColor(R.Colors.indicatorsFlashing)
                        .scaleEffect(gameVM.scaleEffect)
                        .opacity(gameVM.opacityEffect)
                        .padding(.bottom, 20)

                    GameBoardView(geometry: geometry)
                    
                    Spacer()
                    VStack(spacing: 10) {
                        TurnView()
                        WinRatesView()
                    }
                    .padding(.horizontal)
                    Spacer()
                    
                    AIStatusView()
                }
                .scenePadding([.top, .bottom])
                
                if gameVM.showingSheet {
                    WinnerView()
                        .zIndex(2)
                        .transition(.asymmetric(insertion: .scale.combined(with: .opacity).animation(.spring(response: 0.3, dampingFraction: 0.7)),
                                                removal: .scale.combined(with: .opacity).animation(.spring(response: 0.3, dampingFraction: 0.7))))
                }
            }
            .onAppear {
                gameVM.restartMatch()
            }
        }
        .toolbar(.hidden, for: .bottomBar)
        .alert(gameVM.alertItem?.title ?? Text(""),
               isPresented: $gameVM.showingAlert,
               presenting: gameVM.alertItem,
               actions: { _ in AlertButtonsView() },
               message: { item in item.message })
        .confirmationDialog("activation_ai".localized,
                            isPresented: $gameVM.showingActiveAIDialog,
                            titleVisibility: .visible,
                            actions: { AlertButtonsView() },
                            message: { Text("ai_difficalty_select".localized) })
    }
}
