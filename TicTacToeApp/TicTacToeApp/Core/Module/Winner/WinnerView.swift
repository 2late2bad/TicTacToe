//
//  WinnerView.swift
//  TicTacToeApp
//
//  Created by Alexander Vagin on 09.06.2023.
//

import SwiftUI

struct WinnerView: View {
    
    @StateObject var winnerVM = WinnerViewModel()
    @EnvironmentObject var gameVM: GameViewModel
    
    var body: some View {
        ZStack {
            R.Colors.background
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("winner_label".localized)
                    .font(R.Fonts.Marske(size: 60))
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
                    .foregroundColor(R.Colors.indicatorsFlashing)
                    .transition(.scale)
                    .padding(.bottom, 20)
                
                Spacer()
                if gameVM.isCrossTurn {
                    CrossCustomView(width: 140,
                                    height: 18,
                                    degress: -45,
                                    anim: false,
                                    angleForce: 0.12)
                    .frame(width: 210, height: 210)
                    .foregroundColor(R.Colors.indicatorDefault)
                    .opacity(winnerVM.animationOpacity)
                    
                    Text("\("match_score".localized): \(gameVM.xWins) - \(gameVM.sumOfWins - gameVM.oWins)")
                        .font(R.Fonts.Marske(size: 40))
                        .foregroundColor(R.Colors.text)
                        .padding([.bottom], 60)
                        .padding(.top, 10)
                        .opacity(winnerVM.animationOpacity)
                } else {
                    CircleCustomView(lineWidth: 16)
                        .frame(width: 210, height: 210)
                        .foregroundColor(R.Colors.indicatorDefault)
                        .opacity(winnerVM.animationOpacity)
                    
                    Text("Match score: \(gameVM.sumOfWins - gameVM.oWins) - \(gameVM.xWins)")
                        .font(R.Fonts.Marske(size: 40))
                        .foregroundColor(R.Colors.text)
                        .padding([.bottom], 60)
                        .padding(.top, 10)
                        .opacity(winnerVM.animationOpacity)
                }
                
                Spacer()
                Button {
                    gameVM.showingWinner = false
                    gameVM.restartMatch()
                } label: {
                    Image(systemName: "arrow.clockwise")
                        .imageScale(.large)
                        .foregroundColor(R.Colors.indicatorDefault)
                        .rotationEffect(.degrees(winnerVM.animationDegrees))
                        .shadow(color: R.Colors.indicatorDefault, radius: 1)
                        .onAppear {
                            withAnimation(.linear(duration: 3).repeatForever(autoreverses: false)) {
                                winnerVM.animationDegrees = 360
                            }
                        }
                }
                Spacer()
            }
            .onAppear {
                withAnimation(.easeInOut(duration: 0.7).repeatForever(autoreverses: true)) {
                    winnerVM.animationOpacity = 1
                }
            }
        }
    }
}
