//
//  RecordCellView.swift
//  TicTacToeApp
//
//  Created by Alexander Vagin on 08.08.2023.
//

import SwiftUI

struct RecordCellView: View {
    
    let player: Player
    let score: String
    let type: TypeGame
    let complexity: Complexity
    let date: Date
    
    var body: some View {
        HStack {
            CrossCustomView(width: 15, height: 3, degress: 45, anim: false)
                .frame(width: 26, height: 26)
                .foregroundColor(R.Colors.recordElement)
                .opacity(player == .cross ? 1 : 0.3)
            CircleCustomView(lineWidth: 3)
                .frame(width: 26, height: 26)
                .foregroundColor(R.Colors.recordElement)
                .opacity(player == .zero ? 1 : 0.3)
            Spacer()
            Text(score)
                .font(R.Fonts.Marske(size: 22))
                .foregroundColor(R.Colors.text)
                .lineLimit(1)
            Spacer()
            Text(type == .PvP ? type.rawValue : "\(type.rawValue) \(complexity.rawValue)")
                .frame(width: 64)
                .foregroundColor(R.Colors.text)
                .lineLimit(1)
                .font(R.Fonts.Marske(size: 20))
            Spacer()
            Text(date.displayFormat())
                .frame(width: 120)
                .foregroundColor(R.Colors.text)
                .font(R.Fonts.Marske(size: 20))
                .lineLimit(1)
                .minimumScaleFactor(0.7)
        }
    }
}

struct RecordCellView_Previews: PreviewProvider {
    static var previews: some View {
        RecordCellView(player: .cross, score: "3 - 1", type: .AI, complexity: .HELL, date: .now)
    }
}
