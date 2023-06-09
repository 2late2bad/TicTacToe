//
//  WinnerView.swift
//  TicTacToeApp
//
//  Created by Alexander Vagin on 09.06.2023.
//

import SwiftUI

struct WinnerView: View {
    
    @ObservedObject var viewModel: GameViewModel
    
    var body: some View {
        Text("Winner: \(viewModel.isCrossTurn ? Player.cross.rawValue : Player.zero.rawValue)")
        Button {
            viewModel.restartGame()
            viewModel.showingSheet = false
        } label: {
            Text("back")
        }
    }
}

struct WinnerView_Previews: PreviewProvider {
    static var previews: some View {
        WinnerView(viewModel: GameViewModel(bo: 3))
    }
}
