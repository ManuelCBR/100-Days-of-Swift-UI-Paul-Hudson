//
//  ContentView.swift
//  Day87PaulHudsonFlashzilla
//
//  Created by Manuel Bermudo on 7/9/24.
//

import SwiftUI

struct ContentView: View {
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency
    
    @State private var scale = 1.0
    @State private var counter = 0
    
    var body: some View {
        VStack{
            Text("Timer with counter")
                .onReceive(timer) { time in
                    if counter == 5 {
                        timer.upstream.connect().cancel()
                    } else {
                        print("The time is now \(time)")
                    }
                    
                    counter += 1
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.secondary)
                )
            
            Text("Active, inactive, background")
                .onChange(of: scenePhase) { oldPhase, newPhase in
                    if newPhase == .active {
                        print("Active")
                    } else if newPhase == .inactive {
                        print("Inactive")
                    } else if newPhase == .background {
                        print("Background")
                    }
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.secondary)
                )
        }
        .padding(.top, 40)
        Spacer()
        VStack{
            Text("AccessibilityDifferentiateWithoutColor")
            Image(systemName: "arrow.down")
                .resizable()
                .frame(width: 15, height: 15)
            HStack {
                if differentiateWithoutColor {
                    Image(systemName: "checkmark.circle")
                }
                
                Text("Success")
            }
            .padding()
            .background(differentiateWithoutColor ? .black : .green)
            .foregroundStyle(.white)
            .clipShape(.capsule)
        }
        Spacer()
        VStack{
            Text("AccessibilityDifferentiateWithoutColor")
            Image(systemName: "arrow.down")
            
            Button("AccessibilityReduceMotion") {
                if reduceMotion {
                    scale *= 1.5
                } else {
                    withAnimation {
                        scale *= 1.5
                    }
                }
                
            }
            .scaleEffect(scale)
        }
        Spacer()
        Text("AccessibilityReduceTransparency")
        Image(systemName: "arrow.down")
        Text("Hello, World!")
            .padding()
            .background(reduceTransparency ? .black : .black.opacity(0.5))
            .foregroundStyle(.white)
            .clipShape(.capsule)
        Spacer()
    }
    
}

#Preview {
    ContentView()
}
