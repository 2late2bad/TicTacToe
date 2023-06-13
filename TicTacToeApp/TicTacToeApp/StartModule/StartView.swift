//
//  StartView.swift
//  TicTacToeApp
//
//  Created by Alexander Vagin on 21.03.2023.
//

import SwiftUI

struct StartView: View {
    
    @EnvironmentObject var gameVM: GameViewModel
    @State private var animationAmount = 1.0
    
    private var openAI: Bool { gameVM.selectedTypeOfGame == .PvP }
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(R.Colors.element)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor(R.Colors.foreground)],
                                                               for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.font : R.Fonts.enlargedFont(to: 18)],
                                                               for: .highlighted)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: R.Colors.gradient),
                               startPoint: .top,
                               endPoint: .bottom)
                
                VStack(spacing: 10) {
                    
                    Spacer(minLength: 140)
                    
                    Text(R.Strings.game)
                        .font(R.Fonts.Marske(size: 40))
                        .foregroundColor(R.Colors.text)
                    
                    Spacer(minLength: 90)
                    
                    GoButtonView()
                        .overlay {
                            Circle()
                                .stroke(R.Colors.element)
                                .scaleEffect(animationAmount)
                                .opacity(2 - animationAmount)
                                .animation(.easeInOut(duration: 3).repeatForever(autoreverses: false), value: animationAmount)
                        }
                        .onAppear {
                            animationAmount = 2
                        }
                    
                    Spacer()
                    
                    VStack {
                        Stepper("\(R.Strings.roundsToWin): \(gameVM.sumOfWins)",
                                value: $gameVM.sumOfWins,
                                in: R.Indicators.rangeOfRounds)
                        .font(R.Fonts.DisketMono(size: 15))
                        .padding([.leading, .trailing], 60)
                        .foregroundColor(R.Colors.text)
                        
                        Picker(R.Strings.typeGamePicker, selection: $gameVM.selectedTypeOfGame) {
                            ForEach(TypeGame.allCases) { type in
                                Text(type.rawValue).tag(type)
                            }
                        }
                        .pickerStyle(.segmented)
                        .padding([.leading, .trailing], 60)
                        .padding([.top], 10)
                        
                        Picker(R.Strings.complexityPicker, selection: $gameVM.selectedComplexity) {
                            ForEach(Complexity.allCases) { complexity in
                                Text(complexity.rawValue.capitalized).tag(complexity)
                            }
                        }
                        .pickerStyle(.segmented)
                        .padding([.leading, .trailing], 60)
                        .padding([.top], 8)
                        .opacity(gameVM.selectedTypeOfGame == .PvP ? 0 : 1)
                        .disabled(openAI)
                    }
                    Spacer()
                }
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        Button {
                            //
                        } label: {
                            Image(systemName: R.Images.infoScreenButton).foregroundColor(R.Colors.subScreenButtons)
                        }
                    }
                    ToolbarItem(placement: .bottomBar) {
                        Button {
                            //
                        } label: {
                            Image(systemName: R.Images.settingsScreenButton).foregroundColor(R.Colors.subScreenButtons)
                        }
                    }
                }
            }
            .edgesIgnoringSafeArea(.all)
            .navigationBarHidden(true)
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
