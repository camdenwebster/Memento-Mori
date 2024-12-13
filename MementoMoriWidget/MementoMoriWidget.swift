//
//  MementoMoriWidget.swift
//  MementoMoriWidget
//
//  Created by Camden Webster on 12/9/24.
//

import WidgetKit
import SwiftUI

struct CountdownEntry: TimelineEntry {
    let date: Date
    let remainingTime: String
}

struct CountdownProvider: TimelineProvider {
    func placeholder(in context: Context) -> CountdownEntry {
        CountdownEntry(date: Date(), remainingTime: "Loading...")
    }

    func getSnapshot(in context: Context, completion: @escaping (CountdownEntry) -> Void) {
        let remainingTime = calculateRemainingTime()
        let entry = CountdownEntry(date: Date(), remainingTime: remainingTime)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<CountdownEntry>) -> Void) {
        var entries: [CountdownEntry] = []
        let currentDate = Date()
        
        // Generate a timeline consisting of entries every minute for the next hour
        for minuteOffset in 0..<60 {
            let entryDate = Calendar.current.date(byAdding: .minute, value: minuteOffset, to: currentDate)!
            let remainingTime = calculateRemainingTime(for: entryDate)
            let entry = CountdownEntry(date: entryDate, remainingTime: remainingTime)
            entries.append(entry)
        }
        
        // Create the timeline with the entries and a policy to refresh after the last entry
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }

    private func calculateRemainingTime(for date: Date = Date()) -> String {
        // Retrieve birthdate from UserDefaults
        let birthDate = UserDefaults.standard.object(forKey: "birthDate") as? Date ?? Date()
        let deathDate = Calendar.current.date(byAdding: .weekOfYear, value: 4000, to: birthDate) ?? Date()
        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date, to: deathDate)

        return "\(components.year ?? 0)y \(components.month ?? 0)m \(components.day ?? 0)d, \(components.hour ?? 0):\(components.minute ?? 0)"
    }
}

struct CountdownWidgetView: View {
    var entry: CountdownProvider.Entry

    var body: some View {
        VStack {
            Text("Memento Mori")
                .font(.headline)
                .foregroundColor(.secondary)
            
            Text(entry.remainingTime)
                .font(.title2)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}

@main
struct MementoMoriWidget: Widget {
    let kind: String = "MementoMoriWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: CountdownProvider()) { entry in
            CountdownWidgetView(entry: entry)
        }
        .configurationDisplayName("Memento Mori Timer")
        .description("Displays the time remaining until your estimated death.")
        .supportedFamilies([.systemSmall, .systemMedium]) // Support for small and medium widgets
    }
}
