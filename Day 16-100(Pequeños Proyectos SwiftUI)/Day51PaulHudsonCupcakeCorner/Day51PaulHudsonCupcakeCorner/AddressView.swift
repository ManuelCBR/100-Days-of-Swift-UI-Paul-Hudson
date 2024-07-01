//
//  AddressView.swift
//  Day51PaulHudsonCupcakeCorner
//
//  Created by Manuel Bermudo on 1/7/24.
//

import SwiftUI

struct AddressView: View {
    
    @Bindable var order: Order
    
    var body: some View {
        Form{
            Section{
                TextField("Name", text: $order.name)
                TextField("Street Address", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Zip", text: $order.zip)
            }
            Section{
                NavigationLink("Check out"){
                    CheckoutView(order: order)
                }
            }
            .disabled(order.hasValidAdress == false)
        }
    }
}

#Preview {
    AddressView(order: Order())
}
