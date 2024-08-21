//
//  Day77PaulHudsonMilestonProject13to15App.swift
//  Day77PaulHudsonMilestonProject13to15
//
//  Created by Manuel Bermudo on 20/8/24.
//

import SwiftUI

@main
struct Day77PaulHudsonMilestonProject13to15App: App {
    var body: some Scene {
        WindowGroup {
            ContentView(addPeopleViewModel: AddPeopleViewModel(people: People()))
        }
    }
}
