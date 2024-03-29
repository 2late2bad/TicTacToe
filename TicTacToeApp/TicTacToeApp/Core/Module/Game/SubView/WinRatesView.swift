//
//  WinRatesView.swift
//  TicTacToeApp
//
//  Created by Alexander Vagin on 14.06.2023.
//

import SwiftUI

struct WinRatesView: View {
    
    @EnvironmentObject var gameVM: GameViewModel
    
    var body: some View {
        HStack {
            HStack {
                ForEach(0..<(gameVM.sumOfWins), id: \.self) { i in
                    CrossCustomView(width: 11, height: 2, degress: 45, anim: false)
                        .frame(width: 20, height: 20)
                        .foregroundColor(R.Colors.indicatorDefault)
                        .opacity(i < gameVM.xWins ? 1 : 0.2)
                }
            }
            Spacer(minLength: 20)
            HStack {
                ForEach(0..<(gameVM.sumOfWins), id: \.self) { i in
                    CircleCustomView(lineWidth: R.Indicators.Circle.lineWidthExtra)
                        .frame(width: 20, height: 20)
                        .foregroundColor(R.Colors.indicatorDefault)
                        .opacity(i < gameVM.oWins ? 0.2 : 1)
                }
            }
        }
    }
}
