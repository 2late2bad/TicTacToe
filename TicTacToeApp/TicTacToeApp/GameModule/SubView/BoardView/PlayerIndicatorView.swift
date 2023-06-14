//
//  PlayerIndicatorView.swift
//  TicTacToeApp
//
//  Created by Alexander Vagin on 17.03.2023.
//

import SwiftUI

struct PlayerIndicatorView: View {
    
    var proxy: GeometryProxy
    var move: Player
    
    var body: some View {
        switch move {
        case .cross:
            CrossCustomView()
                .frame(width: proxy.size.width/3 - 15,
                       height: proxy.size.width/3 - 15)
        case .zero:
            CircleCustomView(lineWidth: R.Indicators.Circle.lineWidthDesk)
                .frame(width: proxy.size.width/3 - 15,
                       height: proxy.size.width/3 - 15)
        }
    }
}
