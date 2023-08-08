//
//  StartViewModel.swift
//  TicTacToeApp
//
//  Created by Alexander Vagin on 21.03.2023.
//

import SwiftUI

final class StartViewModel: ObservableObject {
    
    @Published var showInfo: Bool = false
    @Published var showRecords: Bool = false
    
    @Published var animationAmount: Double = 1.0
    @Published var showComplexity: Bool = false
    @Published var fontIncreaseAnimation: CGFloat = 14
    
    public func goButtonAnimation(amount: Double) {
        animationAmount = amount
    }
    
    public func fontAnimation(duration: Double) {
        withAnimation(.easeOut(duration: duration)) {
            fontIncreaseAnimation = 20
        }
        withAnimation(.easeIn(duration: duration).delay(duration)) {
            fontIncreaseAnimation = 16
        }
    }
    
    public func gameTypeChange(_ type: TypeGame) {
        type == .AI ? (showComplexity = true) : (showComplexity = false)
    }
}
