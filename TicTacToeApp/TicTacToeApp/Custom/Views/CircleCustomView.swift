//
//  CircleCustomView.swift
//  TicTacToeApp
//
//  Created by Alexander Vagin on 16.03.2023.
//

import SwiftUI

struct CircleCustomView: View {
    
    @State private var isRotated: Bool = false
    let lineWidth: CGFloat
    
    var body: some View {
        Circle()
            .strokeBorder(lineWidth: lineWidth)
            .rotation3DEffect(.degrees(isRotated ? 0 : -90), axis: (x: 0.5, y: 0, z: 1))
            .opacity(isRotated ? 1 : 0)
            .onAppear {
                withAnimation(.easeOut(duration: 0.2)) {
                    isRotated = true
                }
            }
    }
}

struct CustomCircle_Previews: PreviewProvider {
    static var previews: some View {
        CircleCustomView(lineWidth: 16)
            .frame(width: 200)
    }
}
