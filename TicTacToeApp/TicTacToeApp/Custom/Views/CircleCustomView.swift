//
//  CircleCustomView.swift
//  TicTacToeApp
//
//  Created by Alexander Vagin on 16.03.2023.
//

import SwiftUI

struct CircleCustomView: View {
    
    let clockTotal: Float
    let clockValue: Float
    
    var radius: CGFloat = 200
    var lineWidth: CGFloat = 16
    var tintColor: Color = .orange

    var body: some View {
        
        ZStack {
            
            Circle()
                .stroke(tintColor .opacity(0.2),
                        style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
            
            Circle()
                .trim(from: 0.0, to: 0.4)
                .stroke(tintColor,
                        style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
            
        }
        .frame(width: radius)
        
    }
}

struct CustomCircle_Previews: PreviewProvider {
    static var previews: some View {
        CircleCustomView(clockTotal: 100, clockValue: 40)
    }
}
