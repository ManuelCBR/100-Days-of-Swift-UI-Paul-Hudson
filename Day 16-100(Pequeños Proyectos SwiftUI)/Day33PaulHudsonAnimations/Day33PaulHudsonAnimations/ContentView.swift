//
//  ContentView.swift
//  Day33PaulHudsonAnimations
//
//  Created by Manuel Bermudo on 10/6/24.
//

import SwiftUI

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint

    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}
extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading)
        )
    }
}

struct ContentView: View {
    
    let letters = Array("Hello SwiftUI")
    
    @State private var enabled = true
    @State private var enabled2 = false
    @State private var dragAmount = CGSize.zero
    @State private var isShowingOrange = false
    @State private var isShowingRed = false
    
    
    
    var body: some View {
        ZStack{
            LinearGradient(colors: [.gray, .black], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack{
                Text("Animations")
                    .font(.largeTitle)
                    .underline()
                    .foregroundStyle(.orange)
                Spacer()
                LinearGradient(colors: [.yellow, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .frame(width: 300, height: 200)
                    .clipShape(.rect(cornerRadius: 10))
                    .offset(dragAmount)
                    .gesture(
                        DragGesture()
                            .onChanged{dragAmount = $0.translation}
                            .onEnded{ _ in
                                withAnimation(.bouncy){
                                    dragAmount = .zero
                                }
                            }
                    )
                Button("Tap me"){
                    enabled.toggle()
                }
                .frame(width: 300, height: 150)
                .background(enabled ? .blue : .orange)
                .foregroundColor(.white)
                .animation(nil, value: enabled)
                .clipShape(.rect(cornerRadius: enabled ? 60 : 0))
                .animation(.spring(duration: 1, bounce: 0.9), value: enabled)
                
                HStack(spacing: 0){
                    ForEach(0..<letters.count, id: \.self) {num in
                        Text(String(letters[num]))
                            .padding(5)
                            .font(.title)
                            .background(enabled2 ? .blue : .red)
                            .offset(dragAmount)
                            .animation(.linear.delay(Double(num) / 20), value: dragAmount)
                    }
                }
                .gesture(
                    DragGesture()
                        .onChanged{dragAmount = $0.translation}
                        .onEnded{_ in
                            dragAmount = .zero
                            enabled2.toggle()
                        }
                )
                VStack{
                    Button("Tap me too"){
                        withAnimation{
                            isShowingOrange.toggle()
                        }
                    }
                    if isShowingOrange{
                        Rectangle()
                            .fill(.orange)
                            .frame(width: 300, height: 100)
                            .transition(.asymmetric(insertion: .scale, removal: .opacity))
                    }
                }
                Spacer()
                ZStack{
                    Rectangle()
                        .fill(.blue)
                        .frame(width: 300, height: 100)
                    if isShowingRed {
                        Rectangle()
                            .fill(.red)
                            .frame(width: 300, height: 100)
                            .transition(.pivot)
                    }
                }
                .onTapGesture{
                    withAnimation{
                        isShowingRed.toggle()
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
