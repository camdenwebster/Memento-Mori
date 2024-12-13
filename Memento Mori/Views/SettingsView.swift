//
//  SettingsView.swift
//  Memento Mori
//
//  Created by Camden Webster on 12/9/24.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var settings: SettingsViewModel

    var body: some View {
        Form {
            DatePicker("Birth Date", selection: $settings.birthDate, displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
        }
        .navigationTitle("Settings")
    }
}
