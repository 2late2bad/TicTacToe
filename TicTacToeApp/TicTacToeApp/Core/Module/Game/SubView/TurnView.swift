//
//  TurnView.swift
//  TicTacToeApp
//
//  Created by Alexander Vagin on 14.06.2023.
//

import SwiftUI

struct TurnView: View {
    
    @EnvironmentObject var gameVM: GameViewModel
    
    var body: some View {
        HStack {
            Text("TURN:")
                .font(R.Fonts.DisketMono(size: 20))
                .foregroundColor(R.Colors.text)
            CrossCustomView(width: 10, height: 2, degress: 45, anim: false)
                .frame(width: 20, height: 20)
                .foregroundColor(R.Colors.indicatorDefault)
                .opacity(gameVM.isCrossTurn ? 1 : 0.2)
            CircleCustomView(lineWidth: R.Indicators.Circle.lineWidthExtra)
                .frame(width: 20, height: 20)
                .foregroundColor(R.Colors.indicatorDefault)
                .opacity(gameVM.isCrossTurn ? 0.2 : 1)
        }
    }
}


