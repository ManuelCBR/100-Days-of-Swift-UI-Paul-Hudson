//
//  Day53PaulHudsonBookwormApp.swift
//  Day53PaulHudsonBookworm
//
//  Created by Manuel Bermudo on 2/7/24.
//

import SwiftData
import SwiftUI

@main
struct Day53PaulHudsonBookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Student.self)
    }
}
