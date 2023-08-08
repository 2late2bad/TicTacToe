//
//  DefinitionComplexityView.swift
//  TicTacToeApp
//
//  Created by Alexander Vagin on 14.06.2023.
//

import SwiftUI

struct DefinitionComplexityView: View {
    
    @ObservedObject var startVM: StartViewModel
    @EnvironmentObject var gameVM: GameViewModel
    
    var body: some View {
        VStack {
            if startVM.showComplexity {
                Text("difficalty_level".localized)
                    .font(R.Fonts.DisketMono(size: 14))
                    .transition(.move(edge: .top).combined(with: .opacity))
                Picker(R.Strings.complexityPicker, selection: $gameVM.selectedComplexity) {
                    ForEach(Complexity.allCases) { complexity in
                        Text(complexity.title.capitalized).tag(complexity)
                    }
                }
                .pickerStyle(.segmented)
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .frame(height: 60)
        .animation(.easeInOut(duration: 0.3),
                   value: startVM.showComplexity)
    }
}
