//
//  ContentView.swift
//  Day18PaulHudsonWeSplit
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
    var totalAmount: Double{ //Challenge Day 18 (Total amount)
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        return grandTotal
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
                /**
                 Challenge Day 18
                 (Change the tip percentage picker to show a new screen rather than using a segmented control, and give it a wider range of options – everything from 0% to 100%)
                 */
                Section("Select your tip"){
                        Picker("Tip percentage", selection: $tipPercentage){
                            ForEach(0..<101){
                                Text("\($0)%")
                            }
                        }
                        .pickerStyle(.navigationLink)
                }
                
                 //Challenge Day 18 (Add a header to the third section, saying “Amount per person)
                Section("Amount per person"){
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))
                }
                /**
                 Challenge Day 18 (Add another section showing the total amount for the check – i.e., the original amount plus tip value, without dividing by the number of people)
                 */
                Section("Total Amount"){
                    Text(totalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))
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
