//
//  RecordViewModel.swift
//  TicTacToeApp
//
//  Created by Alexander Vagin on 08.08.2023.
//

import SwiftUI

final class RecordViewModel: ObservableObject {
    
    @Published var records: [RecordModel]
    
    private let storage: StorageServiceProtocol = StorageService.shared
    
    init() {
        if let model: [RecordModel] = storage.decodableData(forKey: .records) {
            records = model.sorted { $0.date > $1.date }
        } else {
            records = []
        }
    }
}
