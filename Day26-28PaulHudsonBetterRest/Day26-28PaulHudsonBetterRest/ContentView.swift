//
//  ContentView.swift
//  Day26PaulHudsonBetterRest
//
//  Created by Manuel Bermudo on 6/6/24.
//
import CoreML
import SwiftUI

struct ContentView: View {
    
    @State private var sleepAmount = 8.0
    @State private var wakeUp = defaultWakeUp
    @State private var coffeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = "Timer"
    @State private var showingAlert = false
    
    static var defaultWakeUp: Date{
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    var body: some View {
        NavigationStack{
            Form{
                //Challenge 1: Replace each VStack in our form with a Section, where the text view is the title of the section
                Section(header: Text("When do yo want wake up?").font(.headline)){
                    DatePicker("Please enter a date", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .onChange(of: wakeUp){
                            calculateBedTime()
                        }
                }
                Section(header: Text("Desire of amount of sleep?").font(.headline)){
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25 )
                        .onChange(of: sleepAmount){
                            calculateBedTime()
                        }
                }
                Section(header:  Text("Daily coffe intake").font(.headline)){
                    //Challenge 2: Replace the “Number of cups” stepper with a Picker showing the same range of values
                    //Stepper("^[\(coffeAmount) cup](inflect: true)", value: $coffeAmount, in: 1...20)
                    Picker("^[\(coffeAmount) cup](inflect: true)", selection: $coffeAmount){
                        ForEach(1..<21){
                            Text("\($0 - 1)")
                        }
                    }.pickerStyle(.menu)
                        .onChange(of: coffeAmount){
                            calculateBedTime()
                        }
                    
                }
                //Challenge 3: Change the user interface so that it always shows their recommended bedtime using a nice and large font. You should be able to remove the “Calculate” button entirely.
                Section{
                    VStack{
                        Text("Your ideal bed time is")
                            .font(.title)
                            .foregroundStyle(Color(#colorLiteral(red: 0, green: 0.2834590673, blue: 0.6651245952, alpha: 1)))
                        Text(alertMessage)
                            .font(.largeTitle)
                            .foregroundStyle(Color(#colorLiteral(red: 1, green: 0.2969147265, blue: 0, alpha: 1)))
                            .padding(10)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                .listRowBackground(Color(#colorLiteral(red: 0.8376609683, green: 0.8433836102, blue: 1, alpha: 1)))
            }
            .navigationTitle("Better Rest")
            //Challenge 3:
            /*.toolbar{
                Button("Calculate", action: calculateBedTime)
            }
            .alert(alertTitle, isPresented: $showingAlert){
                Button("OK"){}
            }message: {
                Text(alertMessage)
            }*/
        }
    }
    func calculateBedTime(){
        do{
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double (coffeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            
            alertTitle = "Your ideal bedtime is..."
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
        }catch{
            alertTitle = "Error"
            alertMessage = "Sorry, there was an error calculating your bedtime"
        }
        showingAlert = true
    }
}

#Preview {
    ContentView()
}
