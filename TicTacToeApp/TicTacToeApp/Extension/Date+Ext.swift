//
//  Date+Ext.swift
//  TicTacToeApp
//
//  Created by Alexander Vagin on 08.08.2023.
//

import Foundation

extension Date {
        
    func displayFormat() -> String {
        let formatStyle = FormatStyle(locale: .init(identifier: "ru_RU"))
        return self.formatted(
            formatStyle
                .hour()
                .minute()
                .day()
                .month(.twoDigits)
                .year(.twoDigits)
        )
    }
}
