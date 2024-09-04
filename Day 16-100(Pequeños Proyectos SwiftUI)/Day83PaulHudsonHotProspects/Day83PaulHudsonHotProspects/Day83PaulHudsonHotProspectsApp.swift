//
//  Day83PaulHudsonHotProspectsApp.swift
//  Day83PaulHudsonHotProspects
//
//  Created by Manuel Bermudo on 4/9/24.
//

import SwiftUI

@main
struct Day83PaulHudsonHotProspectsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Prospect.self)
    }
}
