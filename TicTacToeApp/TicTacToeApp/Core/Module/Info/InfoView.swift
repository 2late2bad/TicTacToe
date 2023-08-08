//
//  InfoView.swift
//  TicTacToeApp
//
//  Created by Alexander Vagin on 07.08.2023.
//

import SwiftUI

struct InfoView: View {
    
    var body: some View {
        ZStack() {
            R.Colors.background
                .ignoresSafeArea()
            
            VStack(spacing: 40) {
                VStack(spacing: 4) {
                    Text("created_by".localized + " \(R.Strings.creator)")
                        .font(R.Fonts.DisketMono(size: 22))
                        .foregroundColor(R.Colors.text)
                    Text("all_right_reserved".localized)
                        .font(R.Fonts.DisketMono(size: 18))
                        .foregroundColor(R.Colors.buttonSet)
                }
                
                VStack(spacing: 2) {
                    Text("version".localized + " \(R.Strings.version)")
                        .font(R.Fonts.DisketMono(size: 16))
                        .foregroundColor(R.Colors.text)
                    Text("updated".localized + " \(R.Strings.updated)")
                        .font(R.Fonts.DisketMono(size: 16))
                        .foregroundColor(R.Colors.buttonSet)
                }
            }
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
