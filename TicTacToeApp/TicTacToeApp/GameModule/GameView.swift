//
//  GameView.swift
//  TicTacToeApp
//
//  Created by Alexander Vagin on 16.03.2023.
//

import SwiftUI

struct GameView: View {
    
    @StateObject private var viewModel = GameViewModel(bo: 1)
    
    var body: some View {
        GeometryReader { geometry in
            
            HStack {
                Button {
                    //
                } label: {
                    Image(systemName: "xmark.circle")
                        .imageScale(.large)
                        .foregroundColor(.gray)
                }
                Spacer()
                Button {
                    viewModel.muteSound.toggle()
                } label: {
                    Image(systemName: viewModel.muteSound ? "speaker.slash.fill" : "speaker")
                        .imageScale(.large)
                        .foregroundColor(viewModel.muteSound ? .red : .gray)
                }
            }
            .padding()
            
            VStack {
                
                Text("ROUND \(viewModel.currentRound)")
                    .font(Font.custom("Marske", size: 50))

                Text("FIRST BLOOD")
                    .font(Font.custom("Cyberpunk", size: 30))
                    .foregroundColor(.brown)
                    .scaleEffect(viewModel.animationAmount)
                    .opacity(!viewModel.winningCells.isEmpty ? viewModel.animationAmount : 0)
                    .animation(.easeInOut(duration: 0.25).delay(0.2), value: viewModel.animationAmount)
                    .padding(.bottom, 20)
                
                ZStack {
                    GridCustomView(frameGrid: (width: geometry.size.width, height: geometry.size.width),
                                   indentLines: 12,
                                   thickness: 2,
                                   opacity: 0.2)
                    VStack {
                        LazyVGrid(columns: viewModel.columns, spacing: 17) {
                            ForEach(0..<9) { i in
                                ZStack {
                                    EmptyCellView(proxy: geometry, colorForInvisibility: .white)
                                    
                                    if let move = viewModel.moves[i]?.player {
                                        PlayerIndicatorView(proxy: geometry, move: move)
                                            .foregroundColor(viewModel.winningCells.contains(i) ? viewModel.flashingColor : .black)
                                            .animation(.linear(duration: 0.07).repeatCount(10).delay(0.3), value: viewModel.flashingColor)
                                            .onAppear {
                                                if viewModel.winningCells.contains(i) {
                                                    viewModel.flashingColor = .red
                                                    viewModel.animationAmount = 1
                                                } else {
                                                    viewModel.flashingColor = .black
                                                    viewModel.animationAmount = 0.001
                                                }
                                            }
                                    }
                                }
                                .onTapGesture {
                                    viewModel.processPlayerMove(for: i)
                                }
                            }
                        }
                    } .padding(3).disabled(viewModel.isGameboardDisabled)
                }
                .padding(.top, 10)
                
                HStack {
                    Text("TURN:")
                        .font(Font.custom("Disket Mono", size: 20))
                    CrossCustomView(width: 10, height: 2, degress: 45, anim: false, angleForce: 0.12)
                        .frame(width: 20, height: 20)
                        .opacity(viewModel.isCrossTurn ? 1 : 0.2)
                    CircleCustomView(lineWidth: 2)
                        .frame(width: 20, height: 20)
                        .opacity(viewModel.isCrossTurn ? 0.2 : 1)
                }
                .padding(.top, 50)
                .padding(.bottom, 20)
                
                VStack {
                    
                    HStack {
                        HStack {
                            ForEach(0..<(viewModel.sumOfWins), id: \.self) { i in
                                CrossCustomView(width: 12, height: 2, degress: 45, anim: false, angleForce: 0.14)
                                    .frame(width: 20, height: 20)
                                    .opacity(i < viewModel.xWins ? 1 : 0.1)
                            }
                        }
                        Spacer(minLength: 20)
                        HStack {
                            ForEach(0..<(viewModel.sumOfWins), id: \.self) { i in
                                CircleCustomView(lineWidth: 2)
                                    .frame(width: 20, height: 20)
                                    .opacity(i < viewModel.oWins ? 0.1 : 1)
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
        .fullScreenCover(isPresented: $viewModel.showingSheet) {
            WinnerView(viewModel: viewModel)
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
