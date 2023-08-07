//
//  WinnerView.swift
//  TicTacToeApp
//
//  Created by Alexander Vagin on 09.06.2023.
//

import SwiftUI

struct WinnerView: View {
    
    @EnvironmentObject var gameVM: GameViewModel
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                R.Colors.background
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    Text("Winner")
                        .font(R.Fonts.Cyberpunk(size: 60))
                        .foregroundColor(R.Colors.element)
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
                        
                        Text("Match score: \(gameVM.xWins) - \(gameVM.sumOfWins - gameVM.oWins)")
                            .font(R.Fonts.Marske(size: 40))
                            .foregroundColor(R.Colors.text)
                            .padding([.bottom], 60)
                            .padding(.top, 10)
                    } else {
                        CircleCustomView(lineWidth: 16)
                            .frame(width: 210, height: 210)
                            .foregroundColor(R.Colors.indicatorDefault)
                        
                        Text("Match score: \(gameVM.sumOfWins - gameVM.oWins) - \(gameVM.xWins)")
                            .font(R.Fonts.Marske(size: 40))
                            .foregroundColor(R.Colors.text)
                            .padding([.bottom], 60)
                            .padding(.top, 10)
                    }
                    
                    Spacer()
                    Button {
                        gameVM.newRound(andMatch: true)
                        gameVM.showingSheet = false
                    } label: {
                        Image(systemName: "arrow.clockwise")
                            .imageScale(.large)
                            .foregroundColor(R.Colors.indicatorDefault)
                    }
                    .padding([.bottom], 60)
                }
            }

        }
    }
}

//struct WinnerView_Previews: PreviewProvider {
//    static var previews: some View {
//        WinnerView()
//    }
//}
