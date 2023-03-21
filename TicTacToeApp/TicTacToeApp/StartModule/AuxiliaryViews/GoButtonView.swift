//
//  GoButtonView.swift
//  TicTacToeApp
//
//  Created by Alexander Vagin on 22.03.2023.
//

import SwiftUI

struct GoButtonView: View {
    
    let color: Color
    
    var body: some View {
        Button("GO!") {
            //
        }
        .padding(40)
        .background(color)
        .foregroundColor(.white)
        .clipShape(Circle())
        .font(Font.system(size: 30, weight: .medium, design: .serif))
    }
}

struct GoButtonView_Previews: PreviewProvider {
    static var previews: some View {
        GoButtonView(color: .black)
    }
}
