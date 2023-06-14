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
                Text("Difficulty level")
                    .font(R.Fonts.DisketMono(size: 11))
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .padding(.bottom, 5)
                Picker(R.Strings.complexityPicker, selection: $gameVM.selectedComplexity) {
                    ForEach(Complexity.allCases) { complexity in
                        Text(complexity.rawValue.capitalized).tag(complexity)
                    }
                }
                .pickerStyle(.segmented)
                .padding([.leading, .trailing], 60)
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .animation(.easeInOut(duration: 0.3),
                   value: startVM.showComplexity)
    }
}

//struct DefinitionComplexityView_Previews: PreviewProvider {
//    static var previews: some View {
//        DefinitionComplexityView()
//    }
//}
