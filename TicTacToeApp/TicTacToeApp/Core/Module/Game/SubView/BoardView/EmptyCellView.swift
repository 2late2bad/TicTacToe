//
//  EmptyCellView.swift
//  TicTacToeApp
//
//  Created by Alexander Vagin on 17.03.2023.
//

import SwiftUI

struct EmptyCellView: View {
    
    @EnvironmentObject var gameVM: GameViewModel
    
    var proxy: GeometryProxy
    
    var body: some View {
        Rectangle()
            .foregroundColor(R.Colors.background)
            .opacity(gameVM.isGameboardDisabled ? 0 : 1)
            .frame(width: proxy.size.width/3 - 15,
                   height: proxy.size.width/3 - 15)
    }
}
