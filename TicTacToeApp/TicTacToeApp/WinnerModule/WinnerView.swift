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
        Text("Winner: \(gameVM.isCrossTurn ? Player.cross.rawValue : Player.zero.rawValue)")
        Button {
            gameVM.restartGame()
            gameVM.showingSheet = false
        } label: {
            Text("back")
        }
    }
}

//struct WinnerView_Previews: PreviewProvider {
//    static var previews: some View {
//        WinnerView(gameVM: GameViewModel(bo: 3))
//    }
//}
