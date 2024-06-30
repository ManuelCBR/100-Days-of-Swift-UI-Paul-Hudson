//
//  ContentView.swift
//  Day50PaulHudsonCupcakeCorner
//
//  Created by Manuel Bermudo on 30/6/24.
//

import CoreHaptics
import SwiftUI

@Observable
class User: Codable{
    enum CodingKeys: String, CodingKey {
        case _name = "name"
    }
    var name = "Taylor"
}

struct ContentView: View {
    
    //@State private var count = 0
    //@State private var engine: CHHapticEngine?
    @State private var order = Order()
    
    var body: some View {
        /*Encode Taylor", action: encodeTaylor)
            .padding(.vertical)
        Button("Tap to count \(count)"){
            count += 1
        }
        .sensoryFeedback(.impact(weight: .heavy, intensity: 1), trigger: count)
            .padding(.vertical)
            .onAppear(perform: prepareHaptics)
        Button("Play Haptics", action: complexSuccess)
            .padding(.vertical)
            .onAppear(perform: prepareHaptics)
         */
        NavigationStack{
            Form{
                Section{
                    Picker("Select your cake type", selection: $order.type){
                        ForEach(Order.types.indices, id: \.self){
                            Text(Order.types[$0])
                        }
                    }
                    Stepper("Number of cakes: \(order.quantity)", value: $order.quantity, in: 3...20)
                }
                Section{
                    Toggle("Any special request?", isOn: $order.specialRequestEnabled.animation())
                    if order.specialRequestEnabled{
                        Toggle("Add extra frosting", isOn: $order.extraFrostring)
                        Toggle("Add extra sprinkles", isOn: $order.addSprinkles)
                    }
                }
                Section{
                    NavigationLink("Delivery details"){
                        AddressView(order: order)
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
            
    }
    /*
    func encodeTaylor (){
        let data = try! JSONEncoder().encode(User())
        let str = String(decoding: data, as: UTF8.self)
        print(str)
    }
    func prepareHaptics (){
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {return}
        do {
            engine = try CHHapticEngine()
            try? engine?.start()
        }catch{
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    func complexSuccess() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {return}
        var events = [CHHapticEvent]()
        for i in stride(from: 0, to: 1, by: 0.1){
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
            events.append(event)
        }
        for i in stride(from: 0, to: 1, by: 0.1){
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1 - i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 1 + i)
            events.append(event)
        }
        
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        }catch{
            print("Failed to play pattern: \(error.localizedDescription)")
        }
    }
     */
}

#Preview {
    ContentView()
}
