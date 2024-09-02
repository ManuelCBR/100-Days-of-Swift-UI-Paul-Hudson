//
//  ContentView.swift
//  Day79PaulHudsonHotProspects
//
//  Created by Manuel Bermudo on 2/9/24.
//

import SwiftUI

struct ContentView: View {
    
    let users = ["Tohru", "Yuki", "Kyo", "Momiji"]
    @State private var selection = Set<String>()
    @State private var selectedTab = "One"
    
    var body: some View {
        List(users, id: \.self, selection: $selection){user in
            Text(user)
        }
        if selection.isEmpty == false {
            Text("You selected \(selection.formatted())")
        }
        EditButton()
        TabView(selection: $selectedTab) {
            Button("Show tab 2"){
                selectedTab = "Two"
            }
            .tabItem {
                Label("One", systemImage: "star")
            }
            .tag("One")
            
            Text("Tab 2")
                .tabItem {
                    Label("Two", systemImage: "circle")
                }
                .tag("Two")
        }
    }
}

#Preview {
    ContentView()
}
