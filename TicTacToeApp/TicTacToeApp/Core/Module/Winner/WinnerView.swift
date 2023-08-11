//
//  WinnerView.swift
//  TicTacToeApp
//
//  Created by Alexander Vagin on 09.06.2023.
//

import SwiftUI

struct WinnerView: View {
    
    @EnvironmentObject var gameVM: GameViewModel
    @State private var winnerVM = WinnerViewModel()
    @State private var animationDegrees: Double = 0
    @State private var animationOpacity: Double = 0.3
    
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
                    .opacity(animationOpacity)
                    .onAppear {
                        withAnimation(.easeInOut(duration: 0.7).repeatForever(autoreverses: true)) {
                            animationOpacity = 1
                        }
                    }
                    
                    Text("\("match_score".localized): \(gameVM.xWins) - \(gameVM.sumOfWins - gameVM.oWins)")
                        .font(R.Fonts.Marske(size: 40))
                        .foregroundColor(R.Colors.text)
                        .padding([.bottom], 60)
                        .padding(.top, 10)
                        .opacity(animationOpacity)
                        .onAppear {
                            withAnimation(.easeInOut(duration: 0.7).repeatForever(autoreverses: true)) {
                                animationOpacity = 1
                            }
                        }
                } else {
                    CircleCustomView(lineWidth: 16)
                        .frame(width: 210, height: 210)
                        .foregroundColor(R.Colors.indicatorDefault)
                        .opacity(animationOpacity)
                        .onAppear {
                            withAnimation(.easeInOut(duration: 0.7).repeatForever(autoreverses: true)) {
                                animationOpacity = 1
                            }
                        }
                    
                    Text("Match score: \(gameVM.sumOfWins - gameVM.oWins) - \(gameVM.xWins)")
                        .font(R.Fonts.Marske(size: 40))
                        .foregroundColor(R.Colors.text)
                        .padding([.bottom], 60)
                        .padding(.top, 10)
                        .opacity(animationOpacity)
                        .onAppear {
                            withAnimation(.easeInOut(duration: 0.7).repeatForever(autoreverses: true)) {
                                animationOpacity = 1
                            }
                        }
                }
                
                Spacer()
                Button {
                    gameVM.showingSheet = false
                    gameVM.restartMatch()
                } label: {
                    Image(systemName: "arrow.clockwise")
                        .imageScale(.large)
                        .foregroundColor(R.Colors.indicatorDefault)
                        .rotationEffect(.degrees(animationDegrees))
                        .shadow(color: R.Colors.indicatorDefault, radius: 1)
                        .onAppear {
                            withAnimation(.linear(duration: 3).repeatForever(autoreverses: false)) {
                                animationDegrees = 360
                            }
                        }
                }
                Spacer()
            }
        }
    }
}
