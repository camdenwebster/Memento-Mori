//
//  ContentView.swift
//  Memento Mori
//
//  Created by Camden Webster on 12/9/24.
//

import SwiftUI
import SwiftData

import SwiftUI

struct MainView: View {
    @ObservedObject var settings: SettingsViewModel
    
    @State private var timer: Timer?
    @State private var remainingTime: String = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("Memento Mori")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text(remainingTime)
                .font(.title2)
                .multilineTextAlignment(.center)
                .padding()
            
            NavigationLink("Settings", destination: SettingsView(settings: settings))
        }
        .onAppear {
            startTimer()
        }
    }
    
    private func startTimer() {
        let calculator = CountdownCalculator(birthDate: settings.birthDate)
        updateRemainingTime(using: calculator)
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            updateRemainingTime(using: calculator)
        }
    }

    private func updateRemainingTime(using calculator: CountdownCalculator) {
        remainingTime = calculator.timeRemaining()
    }
}

#Preview {
    MainView(settings: SettingsViewModel())
        .modelContainer(for: Item.self, inMemory: true)
}
