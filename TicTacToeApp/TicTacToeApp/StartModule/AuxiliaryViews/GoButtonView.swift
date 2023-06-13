//
//  GoButtonView.swift
//  TicTacToeApp
//
//  Created by Alexander Vagin on 22.03.2023.
//

import SwiftUI

struct GoButtonView: View {
    
    var body: some View {
        NavigationLink {
            GameView()
        } label: {
            Text(R.Strings.goButton)
                .padding(40)
                .background(R.Colors.element)
                .foregroundColor(R.Colors.foreground)
                .clipShape(Circle())
                .font(Font.system(size: 30, weight: .medium, design: .serif))
        }
    }
}

struct GoButtonView_Previews: PreviewProvider {
    static var previews: some View {
        GoButtonView()
    }
}
