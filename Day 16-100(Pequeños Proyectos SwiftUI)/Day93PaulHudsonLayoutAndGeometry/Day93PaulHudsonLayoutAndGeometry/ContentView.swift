//
//  ContentView.swift
//  Day93PaulHudsonLayoutAndGeometry
//
//  Created by Manuel Bermudo on 25/9/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Behavior 1")
            .font(.largeTitle)
            .bold()
            .padding(5)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke()
            )
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(1..<20) { num in
                    GeometryReader { proxy in
                        Image(.songoku)
                            .resizable()
                            .scaledToFit()
                            .padding()
                            .rotation3DEffect(.degrees(-proxy.frame(in: .global).minX) / 8, axis: (x: 0, y: 1, z: 0))
                    }
                    .frame(width: 200, height: 200)
                }
            }
        }
        Text("Behavior 2")
            .font(.largeTitle)
            .bold()
            .padding(5)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke()
            )
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(1..<20) { num in
                    Image(.songoku)
                        .resizable()
                        .scaledToFit()
                        .padding()
                        .frame(width: 200, height: 200)
                        .visualEffect { content, proxy in
                            content
                                .rotation3DEffect(.degrees(-proxy.frame(in: .global).minX) / 8, axis: (x: 0, y: 1, z: 0))
                        }
                }
            }
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned)
    }
}

#Preview {
    ContentView()
}
