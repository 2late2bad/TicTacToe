//
//  GameView.swift
//  TicTacToeApp
//
//  Created by Alexander Vagin on 16.03.2023.
//

import SwiftUI

enum Player {
    case cross, zero
}

struct Move {
    let player: Player
    let boardIndex: Int
    
    var indicator: String {
        return player == .cross ? "cross" : "zero"
    }
}


struct GameView: View {
    
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible())]
    
    @State private var moves: [Move?] = Array(repeating: nil, count: 9)
    @State private var isCrossTurn = true
    
    var body: some View {
        GeometryReader { geometry in
            
            ZStack {
                GridView(frameGrid: (width: geometry.size.width, height: geometry.size.width), indentLines: 8, thickness: 2, opacity: 0.2)
                
                VStack {
                    Spacer()
                    LazyVGrid(columns: columns, spacing: 17) {
                        ForEach(0..<9) { i in
                            ZStack {
                                
//                                CrossView(angleForce: 0.12)
//                                    .frame(width: geometry.size.width/3 - 15,
//                                           height: geometry.size.width/3 - 15)
                                
//                                Circle()
//                                    .strokeBorder(lineWidth: 9)
//                                    .frame(width: geometry.size.width/3 - 15,
//                                           height: geometry.size.width/3 - 15)
                            }
                            .onTapGesture {
                                moves[i] = Move(player: isCrossTurn ? .cross : .zero, boardIndex: i)
                                isCrossTurn.toggle()
                            }
                        }
                    }
                    Spacer()
                } .padding(3)
                
            }
            
        }
 
    }
    
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
