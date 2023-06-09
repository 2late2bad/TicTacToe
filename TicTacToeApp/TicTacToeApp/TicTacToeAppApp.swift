//
//  TicTacToeAppApp.swift
//  TicTacToeApp
//
//  Created by Alexander Vagin on 16.03.2023.
//

import SwiftUI

@main
struct TicTacToeAppApp: App {
    
    @StateObject var gameVM = GameViewModel()
    
    var body: some Scene {
        WindowGroup {
            StartView()
                .environmentObject(gameVM)
        }
    }
}
