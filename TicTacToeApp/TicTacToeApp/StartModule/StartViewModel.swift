//
//  StartViewModel.swift
//  TicTacToeApp
//
//  Created by Alexander Vagin on 21.03.2023.
//

import SwiftUI

final class StartViewModel: ObservableObject {
    
    @Published var animationAmount: Double = 1.0
    @Published var showComplexity: Bool = false
    @Published var fontIncreaseAnimation: CGFloat = 14
    
    public func goButtonAnimation(amount: Double) {
        animationAmount = amount
    }
    
    public func fontAnimation(duration: Double) {
        withAnimation(.easeOut(duration: duration)) {
            fontIncreaseAnimation = 17
        }
        withAnimation(.easeIn(duration: duration).delay(duration)) {
            fontIncreaseAnimation = 14
        }
    }
    
    public func gameTypeChange(_ type: TypeGame) {
        type == .AI ? (showComplexity = true) : (showComplexity = false)
    }

}
