//
//  ContentView.swift
//  Day80PaulHudsonHotProspects
//
//  Created by Manuel Bermudo on 2/9/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var output = ""
    @State private var backgroundColor = Color.red
    
    var body: some View {
        Text(output)
            .task {
                await fetchReadings()
            }
        Image(.example)
            .interpolation(.none)
            .resizable()
            .scaledToFit()
            .background(.black)
        Text("Hello World")
            .padding()
            .background(backgroundColor)
        Text("Change Color")
            .padding()
            .contextMenu(ContextMenu(menuItems: {
                Button("Red", systemImage: "checkmark.circle.fill", role: .destructive){backgroundColor = .red}
                Button("Green"){backgroundColor = .green}
                Button("Blue"){backgroundColor = .blue}
            }))
    }
    
    func fetchReadings() async {
        let fetchTask = Task{
            let url = URL(string: "https://hws.dev/readings.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let readings = try JSONDecoder().decode([Double].self, from: data)
            return "Found \(readings.count) readings"
        }
        let result = await fetchTask.result
        
        switch result {
            case .success(let str):
                output = str
            case .failure(let error):
                output = "Error: \(error.localizedDescription)"
        }
    }
    
}

#Preview {
    ContentView()
}
