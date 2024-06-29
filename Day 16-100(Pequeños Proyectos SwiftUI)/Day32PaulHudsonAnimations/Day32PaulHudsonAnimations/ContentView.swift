//
//  ContentView.swift
//  Day32PaulHudsonAnimations
//
//  Created by Manuel Bermudo on 10/6/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var animationAmount = 1.0
    @State private var animationAmount3D = 0.0
    
    var body: some View {
        VStack{
            Spacer()
            VStack{
                Stepper("Scale amount", value: $animationAmount.animation(
                    .easeInOut(duration: 1)
                    .repeatCount(3, autoreverses: true)
                ), in: 0...10)
            }
            .padding(.horizontal, 40)
            Spacer()
            HStack{
                Button("Stepper"){
                    // Do nothing
                }
                .frame(width: 120, height: 120)
                .background(.blue)
                .foregroundColor(.black)
                .clipShape(.circle)
                .scaleEffect(animationAmount)
                .padding(20)
                Button("3D animation"){
                    withAnimation(.spring(duration: 1, bounce: 0.5)){
                        animationAmount3D += 360
                    }
                }
                .frame(width: 120, height: 120)
                .background(.blue)
                .foregroundColor(.black)
                .clipShape(.circle)
                .rotation3DEffect(.degrees(animationAmount3D), axis: (x: 1.0, y: 0.0, z: 0.0))
                .padding(20)
            }
        }
    }
}

#Preview {
    ContentView()
}
