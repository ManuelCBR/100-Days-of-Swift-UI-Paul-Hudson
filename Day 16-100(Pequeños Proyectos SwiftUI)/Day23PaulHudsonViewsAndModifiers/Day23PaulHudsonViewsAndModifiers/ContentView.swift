//
//  ContentView.swift
//  Day23PaulHudsonViewsAndModifiers
//
//  Created by Manuel Bermudo on 3/6/24.
//

import SwiftUI
struct Title: ViewModifier{
    func body(content: Content) -> some View {
        content
            .font(.title)
            .foregroundColor(.blue)
            .padding()
            .background(.orange)
            .clipShape(.rect(cornerRadius: 20))
    }
}
extension View{
    func titleStyle ()-> some View{
        modifier(Title())
    }
}
struct WaterMark: ViewModifier{
    var text: String
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            
            Text(text)
                .font(.caption)
                .foregroundStyle(.white)
                .padding(5)
                .background(.gray)
                .cornerRadius(5)
        }
    }
}
extension View {
    func watermarked(with text: String) -> some View{
        modifier(WaterMark(text: text))
    }
}
struct GridStack<Content: View>: View{
    let rows: Int
    let columns: Int
    @ViewBuilder let content: (Int, Int) -> Content
    var body: some View{
        VStack{
            ForEach(0..<rows, id: \.self){ row in
                HStack{
                    ForEach(0..<columns, id: \.self){column in
                    content(row, column)
                    }
                }
            }
        }
    }
}

struct ContentView: View {
    @State private var useRedText = true
    var body: some View {
        Text("Modified Text")
            .titleStyle()
        Color.blue
            .frame(width: 300, height: 200)
            .cornerRadius(20)
            .watermarked(with: "By Manuel")
        GridStack(rows: 4, columns: 4){row, col in
                Image(systemName: "\(row * 4 + col).circle")
                Text("R\(row) C\(col)")
        }
    }
}

#Preview {
    ContentView()
}
