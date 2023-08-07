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
                Text("Rounds to win:")
                    .font(R.Fonts.DisketMono(size: 14))
                    .foregroundColor(R.Colors.text)
                Stepper("\(gameVM.sumOfWins)",
                        value: $gameVM.sumOfWins,
                        in: R.Indicators.rangeOfRounds)
                .font(R.Fonts.DisketMono(size: startVM.fontIncreaseAnimation))
                .foregroundColor(R.Colors.text)
                .onChange(of: gameVM.sumOfWins) { _ in
                    startVM.fontAnimation(duration: 0.2)
                }
            }
            .padding([.leading, .trailing], 60)
            
            Picker(R.Strings.typeGamePicker, selection: $gameVM.selectedTypeOfGame) {
                ForEach(TypeGame.allCases) { type in
                    Text(type.rawValue).tag(type)
                }
            }
            .pickerStyle(.segmented)
            .padding([.leading, .trailing], 60)
            .padding([.top], 15)
            .onChange(of: gameVM.selectedTypeOfGame) { type in
                startVM.gameTypeChange(type)
            }
            
        }
    }
}

//struct GameDefinitionView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameDefinitionView()
//    }
//}
