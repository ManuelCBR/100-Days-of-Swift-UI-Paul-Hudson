//
//  Day58PaulHudsonSwiftDataProjectApp.swift
//  Day58PaulHudsonSwiftDataProject
//
//  Created by Manuel Bermudo on 5/7/24.
//

import SwiftData
import SwiftUI

@main
struct Day58PaulHudsonSwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
