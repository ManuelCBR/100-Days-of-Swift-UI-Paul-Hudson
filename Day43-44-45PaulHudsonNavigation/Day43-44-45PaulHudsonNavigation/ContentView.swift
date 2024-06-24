//
//  ContentView.swift
//  Day43-44-45PaulHudsonNavigation
//
//  Created by Manuel Bermudo on 24/6/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var title = "SwiftUI"
    
    var body: some View {
        NavigationStack{
           Text("Hello")
                .toolbar{
                    ToolbarItemGroup(placement: .confirmationAction){
                        Button("Tap me"){
                            
                        }
                        Button("Or Tap me"){
                            
                        }
                    }
                    
                }
                .navigationBarBackButtonHidden()
            Text("Hello world")
                .navigationTitle($title)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
}
