//
//  Day54PaulHudsonBookwormApp.swift
//  Day54PaulHudsonBookworm
//
//  Created by Manuel Bermudo on 2/7/24.
//

import SwiftData
import SwiftUI

@main
struct Day54PaulHudsonBookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
