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
        ZStack {
            R.Colors.background
                .ignoresSafeArea()
            VStack {
                Text("Winner: \(gameVM.isCrossTurn ? Player.cross.rawValue : Player.zero.rawValue)")
                Button {
                    gameVM.newRound(andMatch: true)
                    gameVM.showingSheet = false
                } label: {
                    Text("back")
                }
            }
        }
    }
}

//struct WinnerView_Previews: PreviewProvider {
//    static var previews: some View {
//        WinnerView(gameVM: GameViewModel(bo: 3))
//    }
//}
