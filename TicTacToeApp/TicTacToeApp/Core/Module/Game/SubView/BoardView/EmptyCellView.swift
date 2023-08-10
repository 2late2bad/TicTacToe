//
//  EmptyCellView.swift
//  TicTacToeApp
//
//  Created by Alexander Vagin on 17.03.2023.
//

import SwiftUI

struct EmptyCellView: View {
    
    @State private var opacity: Double = 0
    
    var proxy: GeometryProxy
    
    var body: some View {
        Rectangle()
            .fill(R.Colors.background)
            .frame(width: proxy.size.width/3 - 15,
                   height: proxy.size.width/3 - 15)
            .opacity(opacity)
            .onAppear {
                withAnimation(.linear.delay(1)) {
                    opacity = 1
                }
            }
    }
}
