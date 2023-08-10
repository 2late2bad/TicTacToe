//
//  GameView.swift
//  TicTacToeApp
//
//  Created by Alexander Vagin on 16.03.2023.
//

import SwiftUI

struct GameView: View {
    
    @EnvironmentObject var gameVM: GameViewModel
    @EnvironmentObject var startVM: StartViewModel

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                R.Colors.background
                    .ignoresSafeArea()
                
                VStack(alignment: .center) {
                    HeadButtonsView()
                        .padding(.horizontal)
                        .padding(.bottom, 6)
                    
                    VStack(spacing: 0) {
                        Text("\("round".localized) \(gameVM.currentRound)")
                            .font(R.Fonts.Marske(size: 50))
                            .lineLimit(1)
                            .foregroundColor(R.Colors.text)
                            .rotation3DEffect(.degrees(gameVM.roundLabelRotation), axis: (x: 1, y: 0, z: 0))
                            .animation(.spring(dampingFraction: 0.7), value: gameVM.roundLabelRotation)

                        VStack(spacing: 0) {
                            if gameVM.showingOutcome {
                                Text(gameVM.textOutcome)
                                    .font(R.Fonts.Cyberpunk(size: 30))
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.9)
                                    .foregroundColor(R.Colors.indicatorsFlashing)
                                    .transition(.scale)
                            }
                        }
                        .frame(height: 40)
                        .animation(.easeInOut(duration: 0.3),
                                   value: gameVM.showingOutcome)
                    }
                    .padding(.bottom, 10)
                    
                    GameBoardView(geometry: geometry)
                    
                    Spacer()
                    VStack(spacing: 10) {
                        TurnView()
                        WinRatesView()
                            .padding(.horizontal)
                    }
                    Spacer()
                    
                    AIStatusView()
                }
                .opacity(startVM.showDesk)
                .scenePadding([.top, .bottom])
                
                if gameVM.showingSheet {
                    WinnerView()
                        .zIndex(1)
                        .transition(.scale.combined(with: .opacity).animation(Animation.spring(response: 0.3, dampingFraction: 0.7)))
                }
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
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                gameVM.newRound(andMatch: true)
            }
        }
    }
}
