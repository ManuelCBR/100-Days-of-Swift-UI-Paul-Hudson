//
//  Day59PaulHudsonSwiftDataProjectApp.swift
//  Day59PaulHudsonSwiftDataProject
//
//  Created by Manuel Bermudo on 7/7/24.
//

import SwiftData
import SwiftUI

@main
struct Day59PaulHudsonSwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Expenses.self)
    }
}
