//
//  Day61PaulHudsonTimeForSwiftDataApp.swift
//  Day61PaulHudsonTimeForSwiftData
//
//  Created by Manuel Bermudo on 11/7/24.
//

import SwiftData
import SwiftUI

@main
struct Day61PaulHudsonTimeForSwiftDataApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
