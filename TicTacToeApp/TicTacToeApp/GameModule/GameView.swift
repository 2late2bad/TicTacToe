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
                    gameVM.showingExitAlert = true
                } label: {
                    Image(systemName: "xmark.circle")
                        .imageScale(.large)
                        .foregroundColor(.gray)
                }
                .alert("Leave the match?", isPresented: $gameVM.showingExitAlert) {
                    Button("NO", role: .cancel) {}
                    Button("YES", role: .destructive) {
                        gameVM.restartGame()
                        dismiss()
                    }
                }
                Spacer()
                Button {
                    gameVM.muteSound.toggle()
                } label: {
                    Image(systemName: gameVM.muteSound ? "speaker.slash.fill" : "speaker")
                        .imageScale(.large)
                        .foregroundColor(gameVM.muteSound ? .red : .gray)
                }
            }
            .padding()
            
            VStack {
                
                Text("ROUND \(gameVM.currentRound)")
                    .font(Font.custom("Marske", size: 50))

                Text("FIRST BLOOD")
                    .font(Font.custom("Cyberpunk", size: 30))
                    .foregroundColor(.brown)
                    .scaleEffect(gameVM.animationAmount)
                    .opacity(!gameVM.winningCells.isEmpty ? gameVM.animationAmount : 0)
                    .animation(.easeInOut(duration: 0.25).delay(0.2), value: gameVM.animationAmount)
                    .padding(.bottom, 20)
                
                ZStack {
                    GridCustomView(frameGrid: (width: geometry.size.width, height: geometry.size.width),
                                   indentLines: 12,
                                   thickness: 2,
                                   opacity: 0.2)
                    VStack {
                        LazyVGrid(columns: gameVM.columns, spacing: 17) {
                            ForEach(0..<9) { i in
                                ZStack {
                                    EmptyCellView(proxy: geometry, colorForInvisibility: .white)
                                    
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
                        .font(Font.custom("Disket Mono", size: 20))
                    CrossCustomView(width: 10, height: 2, degress: 45, anim: false, angleForce: 0.12)
                        .frame(width: 20, height: 20)
                        .opacity(gameVM.isCrossTurn ? 1 : 0.2)
                    CircleCustomView(lineWidth: 2)
                        .frame(width: 20, height: 20)
                        .opacity(gameVM.isCrossTurn ? 0.2 : 1)
                }
                .padding(.top, 50)
                .padding(.bottom, 20)
                
                VStack {
                    
                    HStack {
                        HStack {
                            ForEach(0..<(gameVM.sumOfWins), id: \.self) { i in
                                CrossCustomView(width: 12, height: 2, degress: 45, anim: false, angleForce: 0.14)
                                    .frame(width: 20, height: 20)
                                    .opacity(i < gameVM.xWins ? 1 : 0.1)
                            }
                        }
                        Spacer(minLength: 20)
                        HStack {
                            ForEach(0..<(gameVM.sumOfWins), id: \.self) { i in
                                CircleCustomView(lineWidth: 2)
                                    .frame(width: 20, height: 20)
                                    .opacity(i < gameVM.oWins ? 0.1 : 1)
                            }
                        }
                    }
                    .padding([.leading, .trailing], 20)
                    
                }
                
                Text("AI: disabled")
                    .font(Font.custom("Disket Mono", size: 10))
                    .padding(.top, 20)
                    .foregroundColor(.gray)
            }
            .padding(.top, 75)
        }
        .navigationBarHidden(true)
        .fullScreenCover(isPresented: $gameVM.showingSheet) {
            WinnerView()
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
