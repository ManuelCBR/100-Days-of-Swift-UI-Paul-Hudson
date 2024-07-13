//
//  ContentView.swift
//  Day62PaulHudsonInstafilter
//
//  Created by Manuel Bermudo on 13/7/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var blurAmount = 0.0
    @State private var showingConfirmation = false
    @State private var backgroundColor = Color.white
    
    var body: some View {
        VStack{
            Text("Hi There!")
                .blur(radius: blurAmount)
            Slider(value: $blurAmount, in: 0...20)
            Button("Change Color"){
                showingConfirmation.toggle()
            }
            .frame(width: 300, height: 300)
            .background(backgroundColor)
            .clipShape(.rect(cornerRadius: 20))
            .confirmationDialog("Change Background", isPresented: $showingConfirmation){
                Button("Red"){backgroundColor = .red}
                Button("Orange"){backgroundColor = .orange}
                Button("Green"){backgroundColor = .green}
                Button("Cancel", role: .cancel){ }
            }
        }
        .onChange(of: blurAmount){
            oldValue, newValue in
            print("New value is \(newValue)")
            
        }
        
    }
}

#Preview {
    ContentView()
}
