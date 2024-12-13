//
//  SettingsViewModel.swift
//  Memento Mori
//
//  Created by Camden Webster on 12/9/24.
//

import SwiftUI

class SettingsViewModel: ObservableObject {
    @Published var birthDate: Date {
        didSet {
            let defaults = UserDefaults(suiteName: "group.com.yourname.MementoMori")
            defaults?.set(birthDate, forKey: "birthDate")
        }
    }
    
    init() {
        let defaults = UserDefaults(suiteName: "group.com.yourname.MementoMori")
        if let savedDate = defaults?.object(forKey: "birthDate") as? Date {
            self.birthDate = savedDate
        } else {
            self.birthDate = Date()
        }
    }
}
