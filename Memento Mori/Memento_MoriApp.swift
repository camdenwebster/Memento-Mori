//
//  Memento_MoriApp.swift
//  Memento Mori
//
//  Created by Camden Webster on 12/9/24.
//

import SwiftUI

@main
struct MementoMoriApp: App {
    @StateObject private var settings = SettingsViewModel()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                MainView(settings: settings)
            }
        }
    }
}
