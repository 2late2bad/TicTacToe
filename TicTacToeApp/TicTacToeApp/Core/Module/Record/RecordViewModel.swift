//
//  RecordViewModel.swift
//  TicTacToeApp
//
//  Created by Alexander Vagin on 08.08.2023.
//

import SwiftUI

final class RecordViewModel: ObservableObject {
    
    @Published var records = RecordModel.getTest()
}
