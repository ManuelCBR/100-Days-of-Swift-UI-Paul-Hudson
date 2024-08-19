//
//  CheckoutView.swift
//  Day76PaulHudsonAccessibilitySandbox
//
//  Created by Manuel Bermudo on 15/8/24.
//

import SwiftUI

struct CheckoutView: View {
    var order: Order
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    @State private var showingError = false
    
    let label = "Cupcakes"
    
    var body: some View {
        ScrollView{
            VStack{
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) {image in
                    image
                        .resizable()
                        .scaledToFit()
                        .accessibilityLabel(label) //Challenge 1
                }placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Your total cost is \(order.cost, format: .currency(code: "EUR"))")
                    .font(.title)
                Button("Place Order") {
                    Task{
                        order.saveUserOrder()
                        await placeOrder()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Thank you!", isPresented: $showingConfirmation){
            Button("OK") { }
        }message: {
            Text(confirmationMessage)
        }
        .alert("Connection Error", isPresented: $showingError){
            Button ("OK") { }
        }message: {
            Text(confirmationMessage)
        }
    }
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //Coment the next line to test the alert "connection error" forcing the request to fail
        request.httpMethod = "POST"
        
        do{
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity) x  \(Order.types[decodedOrder.type].lowercased()) cupcakes is on the way!"
            showingConfirmation = true
        }catch{
            print("Check out failed: \(error.localizedDescription)")
            confirmationMessage = "There has been a connection error, please try again"
            showingError = true
        }
    }
}

#Preview {
    CheckoutView(order: Order())
}
