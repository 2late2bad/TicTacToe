//
//  StartView.swift
//  TicTacToeApp
//
//  Created by Alexander Vagin on 21.03.2023.
//

import SwiftUI

struct StartView: View {
    
    @StateObject var startVM: StartViewModel = StartViewModel()
    @EnvironmentObject var gameVM: GameViewModel
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(R.Colors.element)
        UISegmentedControl.appearance().setTitleTextAttributes(
            [.foregroundColor : UIColor(R.Colors.foreground)], for: .selected)
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .center) {
                R.Colors.background
                    .ignoresSafeArea()
                
                VStack(spacing: 10) {
                    Spacer()
                    Text("TIC TAC TOE")
                        .font(R.Fonts.Marske(size: 52))
                        .foregroundColor(R.Colors.text)
                    //.shadow(color: .red.opacity(0.7), radius: 8, x: 0, y: 0)
                    Spacer()
                    GoButtonView()
                        .overlay {
                            Circle()
                                .stroke(R.Colors.element)
                                .scaleEffect(startVM.animationAmount)
                                .opacity(2 - startVM.animationAmount)
                                .animation(.easeInOut(duration: 3).repeatForever(autoreverses: false),
                                           value: startVM.animationAmount)
                        }
                        .onAppear {
                            startVM.goButtonAnimation(amount: 2)
                        }
                    Spacer()
                    GameDefinitionView(startVM: startVM)
                        .offset(y: -30)
                    Spacer()
                }
                
                DefinitionComplexityView(startVM: startVM)
                    .offset(y: 305)
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
            .edgesIgnoringSafeArea(.all)
            .navigationBarHidden(true)
        }
    }
}

//struct StartView_Previews: PreviewProvider {
//    static var previews: some View {
//        StartView()
//    }
//}
