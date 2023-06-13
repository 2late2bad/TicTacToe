//
//  GameView.swift
//  TicTacToeApp
//
//  Created by Alexander Vagin on 16.03.2023.
//

import SwiftUI

struct GameView: View {
    
    @EnvironmentObject var gameVM: GameViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        GeometryReader { geometry in
            
            HStack {
                Button {
                    gameVM.alertItem = AlertContext.stopGame
                    gameVM.showingAlert = true
                } label: {
                    Image(systemName: R.Images.exitGameButton)
                        .imageScale(.large)
                        .foregroundColor(.gray)
                }
                Spacer()
                Button {
                    gameVM.muteSound.toggle()
                } label: {
                    Image(systemName: gameVM.muteSound ? R.Images.muteOnButton : R.Images.muteOffButton)
                        .imageScale(.large)
                        .foregroundColor(gameVM.muteSound ? .red : .gray)
                }
            }
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
                
                ZStack {
                    GridView(frameGrid: (width: geometry.size.width, height: geometry.size.width))
                    
                    VStack {
                        LazyVGrid(columns: gameVM.columns, spacing: 17) {
                            ForEach(0..<9) { i in
                                ZStack {
                                    EmptyCellView(proxy: geometry)
                                    
                                    if let move = gameVM.moves[i]?.player {
                                        PlayerIndicatorView(proxy: geometry, move: move)
                                            .foregroundColor(gameVM.winningCells.contains(i) ? gameVM.flashingColor : .black)
                                            .animation(.linear(duration: 0.07).repeatCount(10).delay(0.3), value: gameVM.flashingColor)
                                            .onAppear {
                                                if gameVM.winningCells.contains(i) {
                                                    gameVM.flashingColor = .red
                                                    gameVM.animationAmount = 1
                                                } else {
                                                    gameVM.flashingColor = .black
                                                    gameVM.animationAmount = 0.001
                                                }
                                            }
                                    }
                                }
                                .onTapGesture {
                                    gameVM.processPlayerMove(for: i)
                                }
                            }
                        }
                    } .padding(3).disabled(gameVM.isGameboardDisabled)
                }
                .padding(.top, 10)
                
                HStack {
                    Text("TURN:")
                        .font(R.Fonts.DisketMono(size: 20))
                        .foregroundColor(R.Colors.text)
                    CrossCustomView(width: 10, height: 2, degress: 45, anim: false)
                        .frame(width: 20, height: 20)
                        .opacity(gameVM.isCrossTurn ? 1 : 0.2)
                    CircleCustomView(lineWidth: R.Indicators.Circle.lineWidthExtra)
                        .frame(width: 20, height: 20)
                        .opacity(gameVM.isCrossTurn ? 0.2 : 1)
                }
                .padding(.top, 50)
                .padding(.bottom, 20)
                
                HStack {
                    HStack {
                        ForEach(0..<(gameVM.sumOfWins), id: \.self) { i in
                            CrossCustomView(width: 11, height: 2, degress: 45, anim: false)
                                .frame(width: 20, height: 20)
                                .opacity(i < gameVM.xWins ? 1 : 0.2)
                        }
                    }
                    Spacer(minLength: 20)
                    HStack {
                        ForEach(0..<(gameVM.sumOfWins), id: \.self) { i in
                            CircleCustomView(lineWidth: R.Indicators.Circle.lineWidthExtra)
                                .frame(width: 20, height: 20)
                                .opacity(i < gameVM.oWins ? 0.2 : 1)
                        }
                    }
                }
                .padding([.leading, .trailing], 20)
                
                Text("AI: \(gameVM.selectedTypeOfGame == .PvP ? "Disabled" : gameVM.selectedComplexity.rawValue)")
                    .font(R.Fonts.DisketMono(size: 10))
                    .padding(.top, 20)
                    .foregroundColor(.gray)
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
            .padding(.top, 75)
        }
        .navigationBarHidden(true)
        .fullScreenCover(isPresented: $gameVM.showingSheet) {
            WinnerView()
        }
        .alert(gameVM.alertItem?.title ?? Text(""),
               isPresented: $gameVM.showingAlert,
               presenting: gameVM.alertItem,
               actions: { item in
            switch gameVM.alertItem?.type {
            case .stopGame:
                Button(gameVM.alertItem!.buttonTitle1!, role: .cancel) {}
                Button(gameVM.alertItem!.buttonTitle2!, role: .destructive) {
                    gameVM.restartGame()
                    gameVM.selectedComplexity = .Easy
                    gameVM.selectedTypeOfGame = .PvP
                    dismiss()
                }
            case .disableAI:
                Button(gameVM.alertItem!.buttonTitle1!, role: .cancel) {}
                Button(gameVM.alertItem!.buttonTitle2!, role: .destructive) {
                    gameVM.selectedComplexity = .Easy
                    gameVM.selectedTypeOfGame = .PvP
                }
            case .errorSelectedType:
                Button(gameVM.alertItem!.buttonTitle1!, role: .cancel) {}
            case .none:
                Button("") {}
            }
        }, message: { item in
            item.message
        })
        .confirmationDialog("Do you want to activate AI?",
                            isPresented: $gameVM.showingActiveAIDialog,
                            titleVisibility: .visible, actions: {
            Button("Easy", role: .destructive) {
                gameVM.selectedComplexity = .Easy
                gameVM.selectedTypeOfGame = .AI
            }
            Button("Hard", role: .destructive) {
                gameVM.selectedComplexity = .Hard
                gameVM.selectedTypeOfGame = .AI
            }
            Button("Hell", role: .destructive) {
                gameVM.selectedComplexity = .HELL
                gameVM.selectedTypeOfGame = .AI
            }
        }, message: {
            Text("Select AI difficulty")
        })
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
