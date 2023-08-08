//
//  GameBoardView.swift
//  TicTacToeApp
//
//  Created by Alexander Vagin on 14.06.2023.
//

import SwiftUI

struct GameBoardView: View {
    
    @EnvironmentObject var gameVM: GameViewModel
    let geometry: GeometryProxy
    
    var body: some View {
        ZStack {
            
            GridView(frameGrid: (width: geometry.size.width, height: geometry.size.width))
                .opacity(gameVM.gridOpacity)
            
            VStack {
                LazyVGrid(columns: gameVM.columns, spacing: 17) {
                    ForEach(0..<9) { cell in
                        ZStack {
                            EmptyCellView(proxy: geometry)
                            
                            if let move = gameVM.moves[cell]?.player {
                                PlayerIndicatorView(proxy: geometry, move: move)
                                    .foregroundColor(gameVM.winningCells.contains(cell) ?
                                                     gameVM.indicatorColor : R.Colors.indicatorDefault)
                            }
                        }
                        .onTapGesture {
                            gameVM.processPlayerMove(for: cell)
                        }
                    }
                }
            }
            .disabled(gameVM.isGameboardDisabled)
        }
    }
}
