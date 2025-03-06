//
//  ContentView.swift
//  Day95PaulHudsonMilestonProject16to18
//
//  Created by Manuel Bermudo on 2/1/25.
//

import SwiftUI
import UIKit

/**
 Challenge:
 Your challenge this time can be easy or hard depending on how far you want to take it, but at its core the project is simple: you need to build an app that helps users roll dice then store the results they had.
 At the very least you should lets users roll dice, and also let them see results from previous rolls. However, if you want to push yourself further you can try one or more of the following:
 1. Let the user customize the dice that are rolled: how many of them, and what type: 4-sided, 6-sided, 8-sided, 10-sided, 12-sided, 20-sided, and even 100-sided.
 2. Show the total rolled on the dice.
 3. Store the results using JSON or SwiftData – anywhere they are persistent.
 4. Add haptic feedback when dice are rolled.
 5. For a real challenge, make the value rolled by the dice flick through various possible values before settling on the final figure.
 
 */

struct ContentView: View {
    
    @State var sided = "6"
    @State var dice = "1"
    @State private var results = ""
    @State private var sum = 0
    @State private var isRolling = false
    @State private var currentRotation: Double = 0
    @State private var showingDetails = false
    
    let sidedDice = ["6", "8", "10", "12", "20", "100"]
    let numberOfDice = ["1", "2", "3"]
    
    var body: some View {
        NavigationStack {
            Form{
                Text("Roll the dice")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.orange)
                    .frame(maxWidth: .infinity, alignment: .center)
                Section("Dice type"){
                    Picker("Dice type", selection: $sided){
                        ForEach(sidedDice, id: \.self){ Text($0)
                        }
                    }
                    .pickerStyle(.menu)
                }
                Section("How many dice"){
                    Picker("Number of dice", selection: $dice){
                        ForEach(numberOfDice, id: \.self){ Text($0)
                        }
                        .keyboardType(.decimalPad)
                    }
                    .pickerStyle(.segmented)
                }
                Section("Results") {
                    Text(results.isEmpty ? "No rolls yet" : results)
                        .font(.headline)
                }
                
                Section("Rolling Dice") {
                    Text("🎲")
                        .font(.system(size: 100))
                        .rotationEffect(.degrees(currentRotation))
                        .animation(
                            .linear(duration: 2),
                            value: currentRotation
                        )
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                }
                
                Text("\(String(sum)) point(s)!")
                    .frame(maxWidth: .infinity, alignment: .center)
                
            }
            Button("Roll it!") {
                rollWithHaptics()
            }
            .frame(width: 200, height: 40)
            .background(.orange)
            .foregroundColor(.white)
            .cornerRadius(20)
            .padding(.top, 20)
            .toolbar{
                Button(action: {
                    showingDetails = true
                }) {
                    Image(systemName: "list.bullet")
                }
            }
            .navigationDestination(isPresented: $showingDetails) {
                DetailsView()
            }
        }
    }
    
    func rollDice() {
        guard let diceSides = Int(sided), let diceCount = Int(dice) else { return }
        var rollResults = [Int]()
        var totalSum = 0
        
        for _ in 1...diceCount {
            let roll = Int.random(in: 1...diceSides)
                    rollResults.append(roll)
                    totalSum += roll // Sumar el valor generado al total
        }
        
        results = "You rolled: " + rollResults.map { "\($0)" }.joined(separator: ", ")
        sum = totalSum
    }
    func rollWithHaptics() {
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.prepare()
            isRolling = true
            currentRotation += 1080
            let hapticInterval = 0.2
        
            for i in 0..<10 {
                DispatchQueue.main.asyncAfter(deadline: .now() + hapticInterval * Double(i)) {
                    generator.impactOccurred()
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                rollDice()
                isRolling = false
            }
        }
}

#Preview {
    ContentView()
}
