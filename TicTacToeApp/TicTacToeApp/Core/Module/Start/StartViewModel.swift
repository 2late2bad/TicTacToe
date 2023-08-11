//
//  StartViewModel.swift
//  TicTacToeApp
//
//  Created by Alexander Vagin on 21.03.2023.
//

import SwiftUI

final class StartViewModel: ObservableObject {
    
    @Published var isViewDisabled: Bool = false
    
    @Published var showGame: Bool = false
    @Published var showInfo: Bool = false
    @Published var showRecords: Bool = false

    @Published var showComplexity: Bool = false
    @Published var fontIncreaseAnimation: CGFloat = 14
    @Published var opacityNeedAnim: Double = 1
    
    @Published var scaleGoButton: Double = 1
    @Published var showWaves = false
    @Published var foregroundColorGoButton = R.Colors.foreground
    
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
    
    public func showGameView(_ status: Bool) {
        if status {
            foregroundColorGoButton = .clear
            opacityNeedAnim = 0
            withAnimation(.linear(duration: 0.5)) {
                scaleGoButton = 10
            }
        } else {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7).delay(0.1)) {
                scaleGoButton = 1
            }
            withAnimation(.default.delay(0.8)) {
                foregroundColorGoButton = R.Colors.foreground
                opacityNeedAnim = 1
            }
        }
        
        withAnimation {
            showGame = status
        }
    }
    
    func waitLoad(delay: Double) {
        isViewDisabled = true
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [self] in
            isViewDisabled = false
        }
    }
}
