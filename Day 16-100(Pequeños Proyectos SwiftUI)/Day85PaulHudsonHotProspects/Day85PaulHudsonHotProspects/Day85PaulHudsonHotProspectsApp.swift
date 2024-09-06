//
//  Day85PaulHudsonHotProspectsApp.swift
//  Day85PaulHudsonHotProspects
//
//  Created by Manuel Bermudo on 5/9/24.
//

import SwiftUI

@main
struct Day85PaulHudsonHotProspectsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Prospect.self)
    }
}
