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
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(R.Colors.useElement)
        UISegmentedControl.appearance().setTitleTextAttributes(
            [.foregroundColor : UIColor(R.Colors.foreground)], for: .selected)
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .center) {
                R.Colors.background
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    Spacer()
                    Text("game_name".localized)
                        .font(R.Fonts.Marske(size: 50))
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                        .foregroundColor(R.Colors.text)
                        .padding(.vertical, 40)
                        .padding(.horizontal, 20)
                    Spacer()
                    GoButtonView()
                        .overlay {
                            Circle()
                                .stroke(R.Colors.useElement)
                                .scaleEffect(startVM.animationAmount)
                                .opacity(2 - startVM.animationAmount)
                                .animation(.easeInOut(duration: 3).repeatForever(autoreverses: false),
                                           value: startVM.animationAmount)
                        }
                        .onAppear {
                            startVM.goButtonAnimation(amount: 2)
                        }
                        .padding(.bottom, 20)
                    Spacer()
                    GameDefinitionView(startVM: startVM)
                        .padding(.horizontal, 40)
                        .padding(.vertical, 20)
                    Spacer()
                }
                
                if startVM.showInfo {
                    InfoView()
                        .zIndex(1)
                        .transition(.opacity.animation(.easeInOut(duration: 0.3)))
                }
                
                if startVM.showRecords {
                    RecordView()
                        .zIndex(1)
                        .transition(.opacity.animation(.easeInOut(duration: 0.3)))
                }
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        if !startVM.showRecords {
                            withAnimation {
                                startVM.showInfo.toggle()
                            }
                        }
                    } label: {
                        if startVM.showInfo {
                            Image(systemName: R.Images.backStartButtonLeft).foregroundColor(R.Colors.buttonSet)
                        } else {
                            Image(systemName: R.Images.infoScreenButton).foregroundColor(R.Colors.buttonSet)
                        }
                    }
                    .opacity(startVM.showRecords ? 0 : 1)
                }
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        if !startVM.showInfo {
                            startVM.showRecords.toggle()
                        }
                    } label: {
                        if startVM.showRecords {
                            Image(systemName: R.Images.backStartButtonRight).foregroundColor(R.Colors.buttonSet)
                        } else {
                            Image(systemName: R.Images.recordsScreenButton).foregroundColor(R.Colors.buttonSet)
                        }
                    }
                    .opacity(startVM.showInfo ? 0 : 1)
                }
            }
            .edgesIgnoringSafeArea(.all)
            .navigationBarHidden(true)
        }
    }
}