//
//  Day56PaulHudsonBookwormApp.swift
//  Day56PaulHudsonBookworm
//
//  Created by Manuel Bermudo on 3/7/24.
//

import SwiftData
import SwiftUI

@main
struct Day56PaulHudsonBookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
