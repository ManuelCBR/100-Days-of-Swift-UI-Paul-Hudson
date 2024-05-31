//
//  ContentView.swift
//  Day17PaulHudsonWeSplit
//
//  Created by Manuel Bermudo on 31/5/24.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var isFocused: Bool
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double{
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))
                        .keyboardType(.decimalPad)
                        .focused($isFocused)
                    Picker("Number of people", selection: $numberOfPeople){
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                Section("Select your tip"){
                        Picker("Tip percentage", selection: $tipPercentage){
                            ForEach(tipPercentages, id: \.self){
                                Text($0, format: .percent)
                            }
                        }
                        .pickerStyle(.segmented)
                }
                Section{
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if isFocused {
                    Button("Done"){
                        isFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
