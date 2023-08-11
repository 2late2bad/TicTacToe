//
//  StartView.swift
//  TicTacToeApp
//
//  Created by Alexander Vagin on 21.03.2023.
//

import SwiftUI

struct StartView: View {
    
    @StateObject var startVM = StartViewModel()
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
                
                VStack(spacing: 40) {
                    Spacer()
                    Text("game_name".localized)
                        .font(R.Fonts.Marske(size: 50))
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                        .foregroundColor(R.Colors.text)
                        .opacity(startVM.opacityNeedAnim)
                        .padding(.horizontal, 20)
                    Spacer()
                    GoButtonView()
                        .scaleEffect(startVM.showWaves ? 1 : 1.1)
                        .shadow(color: R.Colors.indicatorsFlashing, radius: startVM.showWaves ? 0 : 10)
                        .shadow(color: R.Colors.indicatorsFlashing, radius: startVM.showWaves ? 0 : 10)
                        .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true),
                                   value: startVM.showWaves)
                        .onAppear {
                            startVM.showWaves.toggle()
                        }
                        .disabled(startVM.isViewDisabled)
                    Spacer()
                    GameDefinitionView(startVM: startVM)
                        .opacity(startVM.opacityNeedAnim)
                        .padding(.horizontal, 40)
                }
                .padding(.bottom, 40)
                
                if startVM.showGame {
                    GameView()
                        .zIndex(2)
                        .transition(.asymmetric(insertion: .opacity.animation(.linear(duration: 0.5).delay(0.5)),
                                                removal: .opacity.animation(.linear(duration: 0.5))))
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
                                .opacity(startVM.opacityNeedAnim)
                        }
                    }
                    .opacity(startVM.showRecords ? 0 : 1)
                }
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        if !startVM.showInfo {
                            withAnimation(.linear(duration: 0.3)) {
                                startVM.opacityNeedAnim = startVM.opacityNeedAnim == 1 ? 0 : 1
                            }
                            startVM.showRecords.toggle()
                        }
                    } label: {
                        if startVM.showRecords {
                            Image(systemName: R.Images.backStartButtonRight).foregroundColor(R.Colors.buttonSet)
                        } else {
                            Image(systemName: R.Images.recordsScreenButton).foregroundColor(R.Colors.buttonSet)
                                .opacity(startVM.opacityNeedAnim)
                        }
                    }
                    .opacity(startVM.showInfo ? 0 : 1)
                }
            }
            .navigationBarHidden(true)
            .environmentObject(startVM)
        }
    }
}
