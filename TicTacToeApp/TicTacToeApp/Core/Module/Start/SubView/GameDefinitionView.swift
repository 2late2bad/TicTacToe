//
//  GameDefinitionView.swift
//  TicTacToeApp
//
//  Created by Alexander Vagin on 14.06.2023.
//

import SwiftUI

struct GameDefinitionView: View {
    
    @ObservedObject var startVM: StartViewModel
    @EnvironmentObject var gameVM: GameViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text("round_of_wins".localized)
                    .font(R.Fonts.DisketMono(size: 18))
                    .minimumScaleFactor(0.5)
                    .foregroundColor(R.Colors.text)
                    .lineLimit(1)
                Stepper("\(gameVM.sumOfWins)",
                        value: $gameVM.sumOfWins,
                        in: R.Indicators.rangeOfRounds)
                .font(R.Fonts.DisketMono(size: startVM.fontIncreaseAnimation))
                .foregroundColor(R.Colors.text)
                .onChange(of: gameVM.sumOfWins) { _ in
                    startVM.fontAnimation(duration: 0.2)
                }
            }
            
            Picker(R.Strings.typeGamePicker, selection: $gameVM.selectedTypeOfGame) {
                ForEach(TypeGame.allCases) { type in
                    Text(type.title).tag(type)
                }
            }
            .pickerStyle(.segmented)
            .onChange(of: gameVM.selectedTypeOfGame) { type in
                startVM.gameTypeChange(type)
            }
            .padding(.top, 6)
                        
            DefinitionComplexityView(startVM: startVM)
        }
    }
}
