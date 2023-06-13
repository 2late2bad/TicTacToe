//
//  CrossCustomView.swift
//  TicTacToeApp
//
//  Created by Alexander Vagin on 16.03.2023.
//

import SwiftUI

struct CrossCustomView: View {
    
    @State private var width: CGFloat
    @State private var height: CGFloat
    @State private var degress: Double
    let anim: Bool
    let angleForce: CGFloat
    
    init(width: CGFloat = 0,
         height: CGFloat = 0,
         degress: Double = -45,
         anim: Bool = true,
         angleForce: CGFloat = R.Indicators.Cross.angleForce) {
        self.width = width
        self.height = height
        self.degress = degress
        self.anim = anim
        self.angleForce = angleForce
    }
    
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
            if anim {
                withAnimation(.interactiveSpring(response: 0.3, dampingFraction: 0.7)) {
                    width = 80
                    height = 11
                    degress = 45
                }
            }
        }
    }
}

struct CrossCustomView_Previews: PreviewProvider {
    static var previews: some View {
        CrossCustomView(anim: true, angleForce: 0.12)
            .frame(width: 160, height: 160)
    }
}
