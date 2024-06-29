//
//  ContentView.swift
//  Day16PaulHudsonWeSplit
//
//  Created by Manuel Bermudo on 30/5/24.
//

import SwiftUI

struct ContentView: View {
    @State private var tapCount = 0
    @State private var name = ""
    let pilots = ["Marc Marquez", "Alex Marquez", "Jorge Martin", "Pecco Bagnaia"]
    @State var selectedPilot = "Marc Marquez"
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    Picker("Select your Pilot", selection: $selectedPilot){
                        ForEach(pilots, id: \.self){
                            Text($0)
                        }
                    }
                }
                Section{
                    TextField("Enter your name", text: $name)
                    Text("Your name is: \(name)")
                }
                
                Section{
                    Text("This is another section")
                }
                Section{
                    Button("Tap Count: \(tapCount)"){
                        tapCount += 1
                    }
                }
                Section{
                    ForEach(1..<5){
                        Text("Row made with foreach: \($0)")
                    }
                }
            }
            .navigationTitle("Select a Pilot")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
}
