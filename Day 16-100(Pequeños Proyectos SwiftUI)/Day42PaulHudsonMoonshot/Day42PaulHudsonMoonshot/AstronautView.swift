//
//  AstronautView.swift
//  Day42PaulHudsonMoonshot
//
//  Created by Manuel Bermudo on 24/6/24.
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
                Text(astronaut.description)
                    .padding()
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
