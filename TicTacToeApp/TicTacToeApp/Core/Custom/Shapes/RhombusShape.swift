//
//  RhombusShape.swift
//  TicTacToeApp
//
//  Created by Alexander Vagin on 16.03.2023.
//

import SwiftUI

struct RhombusShape: Shape {
    
    let angleForce: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let constWidthIsNotAngle = rect.width * (1 - (angleForce * 2))
        let constWidthForAngle = rect.width * angleForce
        
        path.move(to: CGPoint(x: 0, y: rect.midY))
        path.addLine(to: CGPoint(x: constWidthForAngle, y: 0))
        path.addLine(to: CGPoint(x: constWidthForAngle + constWidthIsNotAngle, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: rect.midY))
        path.addLine(to: CGPoint(x: constWidthForAngle + constWidthIsNotAngle, y: rect.maxY))
        path.addLine(to: CGPoint(x: constWidthForAngle, y: rect.maxY))
        path.closeSubpath()
        
        return path
    }
    
}
