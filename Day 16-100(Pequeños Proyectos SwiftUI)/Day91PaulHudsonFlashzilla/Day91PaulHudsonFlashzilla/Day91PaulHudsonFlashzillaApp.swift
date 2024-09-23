//
//  Day91PaulHudsonFlashzillaApp.swift
//  Day91PaulHudsonFlashzilla
//
//  Created by Manuel Bermudo on 11/9/24.
//

import SwiftData
import SwiftUI

@main
struct Day91PaulHudsonFlashzillaApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Card.self)
    }
}
