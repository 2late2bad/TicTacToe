//
//  Date+Ext.swift
//  TicTacToeApp
//
//  Created by Alexander Vagin on 08.08.2023.
//

import Foundation

extension Date {
    
    var displayFormat: String {
        self.formatted(
            .dateTime
                .hour(.conversationalDefaultDigits(amPM: .omitted))
                .minute(.twoDigits)
                .day(.twoDigits)
                .month(.twoDigits)
                .year(.twoDigits))
    }
}
