//
//  WinnerViewModel.swift
//  TicTacToeApp
//
//  Created by Alexander Vagin on 08.08.2023.
//

import Foundation
import SwiftUI

final class WinnerViewModel: ObservableObject {
    
    @Published var animationDegrees: Double = 0
    @Published var animationOpacity: Double = 0.3
}
