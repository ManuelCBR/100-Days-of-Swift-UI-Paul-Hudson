//
//  DetailsView.swift
//  Day95PaulHudsonMilestonProject16to18
//
//  Created by Manuel Bermudo on 7/1/25.
//

import SwiftUI

struct DetailsView: View {
    
    let items = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"]
    
    var body: some View {
        Text("Historical roll")
            .font(.title)
            .fontWeight(.bold)
            .foregroundStyle(.orange)
        List(items, id: \.self) { item in
            Text(item)
        }
        .listStyle(.automatic)
    }
}

#Preview {
    DetailsView()
}
