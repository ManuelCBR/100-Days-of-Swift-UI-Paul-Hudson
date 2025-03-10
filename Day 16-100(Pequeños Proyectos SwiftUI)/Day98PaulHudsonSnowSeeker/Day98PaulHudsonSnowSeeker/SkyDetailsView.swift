//
//  SkyDetailsView.swift
//  Day98PaulHudsonSnowSeeker
//
//  Created by Manuel Bermudo on 10/3/25.
//

import SwiftUI

struct SkyDetailsView: View {
    
    let resort: Resort
    
    var body: some View {
        Group{
            VStack{
                Text("Elevation")
                    .font(.caption.bold())
                
                Text("\(resort.elevation) m")
                    .font(.title3)
            }
            
            VStack{
                Text("Snow")
                    .font(.caption.bold())
                
                Text("\(resort.snowDepth) cm")
                    .font(.title3)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    SkyDetailsView(resort: .example)
}
