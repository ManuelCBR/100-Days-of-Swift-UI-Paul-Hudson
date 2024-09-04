//
//  Day82PaulHudsonHotProspectsApp.swift
//  Day82PaulHudsonHotProspects
//
//  Created by Manuel Bermudo on 4/9/24.
//

import SwiftData
import SwiftUI

@main
struct Day82PaulHudsonHotProspectsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Prospect.self)
    }
}
