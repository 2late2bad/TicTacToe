//
//  RecordView.swift
//  TicTacToeApp
//
//  Created by Alexander Vagin on 07.08.2023.
//

import SwiftUI

struct RecordView: View {
    
    @StateObject private var recordVM = RecordViewModel()
    
    init() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(R.Colors.recordElement)]
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                R.Colors.background
                    .ignoresSafeArea()
                
                List(recordVM.records, id: \.id) { item in
                    RecordCellView(player: item.winner,
                                   score: item.score,
                                   type: item.type,
                                   complexity: item.complexity,
                                   date: item.date)
                    .listRowBackground(R.Colors.background)
                    .padding(.vertical, 6)
                }
                .listStyle(.inset)
                .scrollContentBackground(.hidden)
                .scrollIndicators(.hidden)
                .scenePadding([.top, .bottom])
            }
            .navigationTitle("records".localized)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView()
    }
}
