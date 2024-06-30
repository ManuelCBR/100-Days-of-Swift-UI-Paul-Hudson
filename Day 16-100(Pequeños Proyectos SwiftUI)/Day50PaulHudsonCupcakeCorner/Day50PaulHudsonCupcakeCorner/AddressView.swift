//
//  AddressView.swift
//  Day50PaulHudsonCupcakeCorner
//
//  Created by Manuel Bermudo on 30/6/24.
//

import SwiftUI

struct AddressView: View {
    
    var order: Order
    
    var body: some View {
        Text("Here is your order")
    }
}

#Preview {
    AddressView(order: Order())
}
