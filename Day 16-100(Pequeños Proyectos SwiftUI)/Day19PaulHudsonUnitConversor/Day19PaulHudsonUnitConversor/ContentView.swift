//
//  ContentView.swift
//  Day19PaulHudsonUnitConversor
//
//  Created by Manuel Bermudo on 1/6/24.
//

import SwiftUI
import Foundation

/**
 You need to build an app that handles unit conversions: users will select an input unit and an output unit, then enter a value, and see the output of the conversion.
 Which units you choose are down to you, but you could choose one of these:
 -Temperature conversion: users choose Celsius, Fahrenheit, or Kelvin.
 -Length conversion: users choose meters, kilometers, feet, yards, or miles.
 -Time conversion: users choose seconds, minutes, hours, or days.
 -Volume conversion: users choose milliliters, liters, cups, pints, or gallons.
 If you were going for length conversion you might have:
 -A segmented control for meters, kilometers, feet, yard, or miles, for the input unit.
 -A second segmented control for meters, kilometers, feet, yard, or miles, for the output unit.
 -A text field where users enter a number.
 -A text view showing the result of the conversion.
 So, if you chose meters for source unit and feet for output unit, then entered 10, you’d see 32.81 as the output.
 You know almost everything you need to build this. In fact, if you go for a simple solution – and I hope you do – the only actually new thing you’ll find is that you need to use a different format option for your text field, because .currency and .percent don’t make sense here. You should choose .number instead, which is suitable for standard numerical input.
 */

struct ContentView: View {
  
    @State var inputUnit = "ºC"
    @State var outputUnit = "ºF"
    @State var inputValue = ""

    let units = ["ºC", "ºF", "ºK"]
    var convertedValue: Double{
        //The comma is replaced by the period so that there are no problems when doing the calculations
        let value = Double(inputValue.replacingOccurrences(of: ",", with: ".")) ?? 0
        var celsiusValue: Double
                 //Firts, the input value is converted from ºF o ºK to ºC
                switch inputUnit {
                case "ºF":
                    celsiusValue = Measurement(value: value, unit: UnitTemperature.fahrenheit).converted(to: .celsius).value
                case "ºK":
                    celsiusValue = Measurement(value: value, unit: UnitTemperature.kelvin).converted(to: .celsius).value
                default:
                    celsiusValue = value
                }
                //Then the value is converted to ºF or ºK for output
                switch outputUnit {
                case "ºF":
                    return Measurement(value: celsiusValue, unit: UnitTemperature.celsius).converted(to: .fahrenheit).value
                case "ºK":
                    return Measurement(value: celsiusValue, unit: UnitTemperature.celsius).converted(to: .kelvin).value
                default:
                    return celsiusValue
                }
    }
    var body: some View {
        
        NavigationStack{
            Form{
                Text("Temperature Converter")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.orange)
                Section("Input"){
                    Picker("Input unit", selection: $inputUnit){
                        ForEach(units, id: \.self){
                            Text($0)
                        }
                        .keyboardType(.decimalPad)
                      
                    }.pickerStyle(.segmented)
                    TextField("Temperature", text: $inputValue)
                        .keyboardType(.decimalPad)
                }
                Section("Output"){
                    Picker("Onput unit", selection: $outputUnit){
                        ForEach(units, id: \.self){
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
                    Text(convertedValue.formatted(.number.precision(.fractionLength(2))))
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
