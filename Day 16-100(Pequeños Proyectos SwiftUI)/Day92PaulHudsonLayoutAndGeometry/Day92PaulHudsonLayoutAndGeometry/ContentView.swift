//
//  ContentView.swift
//  Day92PaulHudsonLayoutAndGeometry
//
//  Created by Manuel Bermudo on 24/9/24.
//

import SwiftUI

extension VerticalAlignment {
    struct MidAccountAndName: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.top]
        }
    }

    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}

struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(0..<10) { position in
                Text("Number \(position)")
                    .alignmentGuide(.leading) { _ in Double(position) * -10 }
            }
        }
        .background(.red)
        .frame(width: 400, height: 400)
        .background(.blue)
        
        HStack(alignment: .midAccountAndName) {
            VStack {
                Text("@cbr_manuel")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center]
                    }
                
                Image(.manuelJBermudo)
                    .resizable()
                    .frame(width: 64, height: 64)
            }

            VStack {
                Text("Full name:")
                Text("MANUEL BERMUDO")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                    .font(.largeTitle)
            }
        }
        Rectangle()
            .frame(height: 3)
        
        Text("Hello, world!")
                .offset(x: 100, y: 100)
                .background(.red)
    }
}

#Preview {
    ContentView()
}
