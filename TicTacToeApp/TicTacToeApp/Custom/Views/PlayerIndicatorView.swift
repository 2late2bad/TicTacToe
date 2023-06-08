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
            CrossCustomView(anim: true, angleForce: 0.12)
                .frame(width: proxy.size.width/3 - 15,
                       height: proxy.size.width/3 - 15)
        case .zero:
            CircleCustomView(lineWidth: 10)
                .frame(width: proxy.size.width/3 - 15,
                       height: proxy.size.width/3 - 15)
        }
    }
}
