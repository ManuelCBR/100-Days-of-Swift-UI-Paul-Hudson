//
//  AstronautView.swift
//  Day76PaulHudsonAccessibilitySandbox
//
//  Created by Manuel Bermudo on 15/8/24.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    var body: some View {
        ScrollView{
            VStack{
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
                    .clipShape(.rect(cornerRadius: 30))
                    .accessibilityLabel("Astronaut \(astronaut.name)")
                    .accessibilityAddTraits(.isImage)
                Text(astronaut.description)
                    .padding()
                    .accessibilityLabel("\(astronaut.description)")
            }
        }
        .background(.darkBackground)
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let astronaut: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    return AstronautView(astronaut: astronaut["aldrin"]!)
        .preferredColorScheme(.dark)
}

