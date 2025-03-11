//
//  WelcomeView.swift
//  Day99PaulHudsonSnowSeeker
//
//  Created by Manuel Bermudo on 11/3/25.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack{
            Text("Welcome to SnowSeeker")
                .font(.largeTitle)
            Text("Please select a resort from left-hand menu; swipe from the edge to show it.")
                .foregroundStyle(.secondary)
        }
        
    }
}

#Preview {
    WelcomeView()
}
