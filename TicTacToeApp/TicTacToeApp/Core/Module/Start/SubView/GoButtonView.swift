//
//  GoButtonView.swift
//  TicTacToeApp
//
//  Created by Alexander Vagin on 22.03.2023.
//

import SwiftUI

struct GoButtonView: View {
    
    @EnvironmentObject var startVM: StartViewModel

    var body: some View {
        Button {
            startVM.showGameView(true)
        } label: {
            Text("go_button".localized)
                .padding(40)
                .background(R.Colors.useElement)
                .foregroundColor(startVM.foregroundColorGoButton)
                .clipShape(Circle())
                .scaleEffect(startVM.scaleGoButton)
                .font(Font.system(size: 30, weight: .medium, design: .serif))
        }
    }
}
