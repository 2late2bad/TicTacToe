//
//  CrossCustomView.swift
//  TicTacToeApp
//
//  Created by Alexander Vagin on 16.03.2023.
//

import SwiftUI

struct CrossCustomView: View {
    
    @State private var width: CGFloat = 0
    @State private var height: CGFloat = 0
    @State private var degress: Double = -45
    let angleForce: CGFloat
    
    var body: some View {
        ZStack {
            ForEach(0..<2) { angleIndex in
                HStack {
                    RhombusShape(angleForce: angleForce)
                        .frame(width: width, height: height)
                    Spacer(minLength: 3)
                    RhombusShape(angleForce: angleForce)
                        .frame(width: width, height: height)
                }
                .rotationEffect(Angle(degrees: Double(angleIndex) * 90))
            }
        }
        .rotationEffect(Angle(degrees: degress))
        .onAppear {
            withAnimation(.interactiveSpring(response: 0.3, dampingFraction: 0.7)) {
                width = 80
                height = 11
                degress = 45
            }
        }
    }
}

struct CrossCustomView_Previews: PreviewProvider {
    static var previews: some View {
        CrossCustomView(angleForce: 0.12)
            .frame(width: 160, height: 160)
    }
}
