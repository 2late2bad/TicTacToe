//
//  GameView.swift
//  TicTacToeApp
//
//  Created by Alexander Vagin on 16.03.2023.
//

import SwiftUI

struct GameView: View {
    
    @StateObject private var viewModel = GameViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                GridCustomView(frameGrid: (width: geometry.size.width, height: geometry.size.width),
                               indentLines: 8,
                               thickness: 2,
                               opacity: 0.2)
                VStack {
                    Spacer()
                    LazyVGrid(columns: viewModel.columns, spacing: 17) {
                        ForEach(0..<9) { i in
                            ZStack {
                                EmptyCellView(proxy: geometry, colorForInvisibility: .white)
                                
                                if let move = viewModel.moves[i]?.player {
                                    PlayerIndicatorView(proxy: geometry, move: move)
                                }
                            }
                            .onTapGesture {
                                viewModel.processPlayerMove(for: i)
                            }
                        }
                    }
                    Spacer()
                } .padding(3).disabled(viewModel.isGameboardDisabled)
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
