//
//  ContentView.swift
//  Day96PaulHudsonSnowSeeker
//
//  Created by Manuel Bermudo on 6/3/25.
//

import SwiftUI

class Player {
    var name = "Anonymous"
    var highScore = 0
}

struct HighScoreView: View {
    var player: Player
    
    var body: some View {
        Text("High score: \(player.highScore)")
    }
}



struct ContentView: View {
    
    @State private var searchText = ""
    @State private var player = Player()
    let allNames = ["Paul", "Manuel", "David", "John", "Mary", "Thomas", "Robert", "Michael", "William", "James"]
    
    var filteredNames: [String] {
        if searchText.isEmpty {
            allNames
        } else {
            allNames.filter { name in
                name.localizedStandardContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationStack{
            List(filteredNames, id: \.self) { name in
                Text(name)
            }
            .searchable(text: $searchText, prompt: "Look for something")
            .navigationTitle("Searching")
            
            VStack{
                Text("Hello, world!")
                HighScoreView(player: player)
            }
        }
    }
}

#Preview {
    ContentView()
}
