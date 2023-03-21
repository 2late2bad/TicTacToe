//
//  StartView.swift
//  TicTacToeApp
//
//  Created by Alexander Vagin on 21.03.2023.
//

import SwiftUI

struct StartView: View {
    
    @State private var selectedComplexity: Complexity = .Easy
    @State private var selectedTypeOfGame: TypeGame = .PvP
    @State private var animationAmount = 1.0
    @State private var rounds = 1
    
    private var colorButton: Color { .red }
    private var openAI: Bool { selectedTypeOfGame == .PvP }
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .red
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.font : UIFont.systemFont(ofSize: 18)], for: .highlighted)
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                Spacer(minLength: 140)
                
                Text("Tic Tac Toe")
                    .font(Font.system(size: 36, weight: .thin, design: .monospaced))
                
                Spacer(minLength: 90)
                
                GoButtonView(color: colorButton)
                    .overlay {
                        Circle()
                            .stroke(colorButton)
                            .scaleEffect(animationAmount)
                            .opacity(2 - animationAmount)
                            .animation(.easeInOut(duration: 3).repeatForever(autoreverses: false), value: animationAmount)
                    }
                    .onAppear {
                        animationAmount = 2
                    }
                
                Spacer()
                
                VStack {
                    Stepper("Rounds: \(rounds)", value: $rounds, in: 1...10)
                        .padding([.leading, .trailing], 60)
                    
                    Picker("Type game", selection: $selectedTypeOfGame) {
                        ForEach(TypeGame.allCases) { type in
                            Text(type.rawValue).tag(type)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding([.leading, .trailing], 60)
                    .padding([.top], 10)
                    
                    Picker("Complexity", selection: $selectedComplexity) {
                        ForEach(Complexity.allCases) { complexity in
                            Text(complexity.title).tag(complexity)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding([.leading, .trailing], 60)
                    .padding([.top], 8)
                    .opacity(selectedTypeOfGame == .PvP ? 0 : 1)
                    .disabled(openAI)
                }
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        //
                    } label: {
                        Image(systemName: "questionmark.circle").foregroundColor(.gray)
                    }
                }
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        //
                    } label: {
                        Image(systemName: "gearshape").foregroundColor(.gray)
                    }
                }
            }
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
