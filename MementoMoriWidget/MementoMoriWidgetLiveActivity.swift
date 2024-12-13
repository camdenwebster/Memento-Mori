//
//  MementoMoriWidgetLiveActivity.swift
//  MementoMoriWidget
//
//  Created by Camden Webster on 12/9/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct MementoMoriWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct MementoMoriWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: MementoMoriWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension MementoMoriWidgetAttributes {
    fileprivate static var preview: MementoMoriWidgetAttributes {
        MementoMoriWidgetAttributes(name: "World")
    }
}

extension MementoMoriWidgetAttributes.ContentState {
    fileprivate static var smiley: MementoMoriWidgetAttributes.ContentState {
        MementoMoriWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: MementoMoriWidgetAttributes.ContentState {
         MementoMoriWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: MementoMoriWidgetAttributes.preview) {
   MementoMoriWidgetLiveActivity()
} contentStates: {
    MementoMoriWidgetAttributes.ContentState.smiley
    MementoMoriWidgetAttributes.ContentState.starEyes
}
