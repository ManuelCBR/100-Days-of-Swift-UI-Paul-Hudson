//
//  Day57PaulHudsonSwiftDataProjectApp.swift
//  Day57PaulHudsonSwiftDataProject
//
//  Created by Manuel Bermudo on 4/7/24.
//

import SwiftUI
import SwiftData

@main
struct Day57PaulHudsonSwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
