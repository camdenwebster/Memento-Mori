//
//  CountdownCalculatorModel.swift
//  Memento Mori
//
//  Created by Camden Webster on 12/9/24.
//

import Foundation

struct CountdownCalculator {
    let birthDate: Date
    let deathDate: Date

    init(birthDate: Date) {
        self.birthDate = birthDate
        self.deathDate = Calendar.current.date(byAdding: .weekOfYear, value: 4000, to: birthDate) ?? Date()
    }

    func timeRemaining() -> String {
        let now = Date()
        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: now, to: deathDate)
        return "\(components.year ?? 0)y \(components.month ?? 0)m \(components.day ?? 0)d \(components.hour ?? 0):\(components.minute ?? 0):\(components.second ?? 0)"
    }
}
