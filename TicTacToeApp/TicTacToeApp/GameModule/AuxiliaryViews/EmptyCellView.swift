//
//  EmptyCellView.swift
//  TicTacToeApp
//
//  Created by Alexander Vagin on 17.03.2023.
//

import SwiftUI

struct EmptyCellView: View {
    
    var proxy: GeometryProxy
    var colorForInvisibility: Color
    
    var body: some View {
        Rectangle()
            .fill(colorForInvisibility)
            .frame(width: proxy.size.width/3 - 15,
                   height: proxy.size.width/3 - 15)
    }
}
