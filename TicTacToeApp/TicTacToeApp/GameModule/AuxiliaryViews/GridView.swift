//
//  GridView.swift
//  TicTacToeApp
//
//  Created by Alexander Vagin on 16.03.2023.
//

import SwiftUI

struct GridView: View {
    
    @State private var actualFrame: (width: CGFloat, height: CGFloat) = (width: 0, height: 0)
    let frameGrid: (width: CGFloat, height: CGFloat)
    var indentLines: CGFloat
    let thickness: CGFloat
    let opacity: Double
    
    init(frameGrid: (width: CGFloat, height: CGFloat),
         indentLines: CGFloat = R.Indicators.Grid.indentLines,
         thickness: CGFloat = R.Indicators.Grid.thickness,
         opacity: Double = R.Indicators.Grid.opacity) {
        self.frameGrid = frameGrid
        self.indentLines = indentLines
        self.thickness = thickness
        self.opacity = opacity
    }
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Rectangle()
                    .frame(width: getFrameWidthNonNegative(actualFrame.width, indentLines), height: thickness)
                    .opacity(opacity)
                Spacer()
                Rectangle()
                    .frame(width: getFrameWidthNonNegative(actualFrame.width, indentLines), height: thickness)
                    .opacity(opacity)
                Spacer()
            }
            .frame(width: frameGrid.width, height: frameGrid.height)
            
            VStack {
                Spacer()
                Rectangle()
                    .frame(width: getFrameWidthNonNegative(actualFrame.width, indentLines), height: thickness)
                    .opacity(opacity)
                Spacer()
                Rectangle()
                    .frame(width: getFrameWidthNonNegative(actualFrame.width, indentLines), height: thickness)
                    .opacity(opacity)
                Spacer()
            }
            .frame(width: frameGrid.width, height: frameGrid.height)
            .rotationEffect(Angle(degrees: 90))
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 0.8)) {
                actualFrame.width = frameGrid.width
                actualFrame.height = frameGrid.height
            }
        }
    }
    
    func getFrameWidthNonNegative(_ width: CGFloat, _ indent: CGFloat) -> CGFloat {
        (width - indent) < 0 ? indent : (width - indent)
    }
}

struct CustomGrid_Previews: PreviewProvider {
    static var previews: some View {
        GridView(frameGrid: (width: 370, height: 370), indentLines: 10, thickness: 2, opacity: 0.2)
    }
}
