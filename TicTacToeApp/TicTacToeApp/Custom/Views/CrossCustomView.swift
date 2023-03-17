//
//  CrossCustomView.swift
//  TicTacToeApp
//
//  Created by Alexander Vagin on 16.03.2023.
//

import SwiftUI

struct CrossCustomView: View {
    
    let angleForce: CGFloat
    
    var body: some View {
        ZStack {
            ForEach(0..<2) { angleIndex in
                HStack {
                    RhombusShape(angleForce: angleForce)
                        .frame(width: 80, height: 11)
                    Spacer(minLength: 3)
                    RhombusShape(angleForce: angleForce)
                        .frame(width: 80, height: 11)
                }
                .rotationEffect(Angle(degrees: Double(angleIndex) * 90))
            }
        }
        .rotationEffect(Angle(degrees: 45))
    }
}
