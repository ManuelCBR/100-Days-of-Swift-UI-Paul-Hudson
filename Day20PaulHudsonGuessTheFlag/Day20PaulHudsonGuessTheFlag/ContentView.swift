//
//  ContentView.swift
//  Day20PaulHudsonGuessTheFlag
//
//  Created by Manuel Bermudo on 2/6/24.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAlert = false
    var body: some View {
        ZStack{
            
            LinearGradient(colors: [.white, .black], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack{
                Text("Hello")
                Text("Second text above the gradient")
                Button{
                    print("Button with image")
                } label:{
                    Label("Edit", systemImage: "pencil")
                        .padding(5)
                        .background(.gray)
                        .cornerRadius(8)
                }
                Button{
                    showingAlert = true
                } label:{
                    Label("Show Alert", systemImage: "exclamationmark.octagon")
                        .padding(5)
                        .foregroundColor(.red)
                        .background(.gray)
                        .cornerRadius(8)
                }
                .alert("Important message", isPresented: $showingAlert){
                    Button("Delete", role: .destructive){}
                    Button("Cancel", role: .cancel){}
                }message: {
                    Text("Please read this")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
