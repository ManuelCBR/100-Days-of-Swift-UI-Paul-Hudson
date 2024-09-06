//
//  ContentView.swift
//  Day85PaulHudsonHotProspects
//
//  Created by Manuel Bermudo on 5/9/24.
//

/**
 Challenge
 One of the best ways to learn is to write your own code as often as possible, so here are three ways you should try extending this app to make sure you fully understand what’s going on.
 - 1. Add an icon to the “Everyone” screen showing whether a prospect was contacted or not.
 - 2. Add an editing screen, so users can adjust the name and email address of someone they scanned previously.      (Tip: Use the simple form of NavigationLink rather than navigationDestination(), to avoid your list selection code        confusing the navigation link.)
 - 3. Allow users to customize the way contacts are sorted – by name or by most recent.
 */


import SwiftUI

struct ContentView: View {

    var body: some View {
        TabView{
            ProspectsView(filter: .none)
                .tabItem { Label("Everyone", systemImage: "person.3") }
            ProspectsView(filter: .contacted)
                .tabItem { Label("Contacted", systemImage: "checkmark.circle") }
            ProspectsView(filter: .uncontacted)
                .tabItem { Label("Uncontacted", systemImage: "questionmark.diamond") }
            MeView()
                .tabItem { Label("Me", systemImage: "person.crop.square") }
        }
    }
}

#Preview {
    ContentView()
}
