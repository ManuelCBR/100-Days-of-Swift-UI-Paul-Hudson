//
//  ContentView.swift
//  Day94PaulHudsonLayoutAndGeometry
//
//  Created by Manuel Bermudo on 6/3/25.
//

import SwiftUI

/*
 Chalenge:
 1. Make views near the top of the scroll view fade out to 0 opacity – I would suggest starting at about 200 points from the top.
 2. Make views adjust their scale depending on their vertical position, with views near the bottom being large and views near the top being small. I would suggest going no smaller than 50% of the regular size.
 3. For a real challenge make the views change color as you scroll. For the best effect, you should create colors using the Color(hue:saturation:brightness:) initializer, feeding in varying values for the hue.
 */

struct ContentView: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]
    
    var body: some View {
        GeometryReader { fullView in
            ScrollView(.vertical) {
                ForEach(0..<50) { index in
                    GeometryReader { proxy in
                        
                        let minY = proxy.frame(in: .global).minY //Challenge 1
                        let opacity  = minY/200 //Challenge 1
                        
                        let fullHeight = fullView.size.height //Challenge 2
                        let scale = max(0.5, min(1.0, 1 - (minY / fullHeight))) //Chalenge 2
                        
                        let hue = Double(minY / fullHeight).truncatingRemainder(dividingBy: 1) //Challenge 3
                        let dynamicColor = Color(hue: hue, saturation: 0.7, brightness: 0.9)
                        
                        Text("Row #\(index)")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            .background(dynamicColor) //Challenge 3
                            .scaleEffect(scale, anchor: .bottom) //Challenge 2
                            .rotation3DEffect(.degrees(proxy.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
                            .opacity(opacity) //Challenge 1
                    }
                    .frame(height: 40)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

