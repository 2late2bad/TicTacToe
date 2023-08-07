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
                    Text("Created by #2late2bad")
                        .font(R.Fonts.DisketMono(size: 22))
                        .foregroundColor(R.Colors.text)
                    Text("All rights reserved")
                        .font(R.Fonts.DisketMono(size: 18))
                        .foregroundColor(R.Colors.buttonSet)
                }
                
                VStack(spacing: 2) {
                    Text("Version 0.8")
                        .font(R.Fonts.DisketMono(size: 16))
                        .foregroundColor(R.Colors.text)
                    Text("Updated 08/2023")
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
