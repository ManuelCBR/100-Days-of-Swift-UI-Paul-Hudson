//
//  Day84PaulHudsonHotProspectsApp.swift
//  Day84PaulHudsonHotProspects
//
//  Created by Manuel Bermudo on 4/9/24.
//

import SwiftUI

@main
struct Day84PaulHudsonHotProspectsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Prospect.self)
    }
}
