//
//  ContentView.swift
//  Day24PaulHudsonViewsAndModifiers
//
//  Created by Manuel Bermudo on 3/6/24.
//

import SwiftUI

/**
 CHALLENGE
 - Go back to project 1 and use a conditional modifier to change the total amount text view to red if the user selects a 0% tip. ✅
 - Go back to project 2 and replace the Image view used for flags with a new FlagImage() view that renders one flag image using the specific set of modifiers we had.✅
 - Create a custom ViewModifier (and accompanying View extension) that makes a view have a large, blue font suitable for prominent titles in a view.
 ATENTION!
 I have grouped the 3 projects in this application to make solving the challenge easier
 */


struct ContentView: View {
    
    var body: some View {
        TabView {
            WeSplit()
                .tabItem {
                    Image(systemName: "plusminus.circle")
                    Text("WeSplit")
                }
            
            GuessTheFlag()
                .tabItem {
                    Image(systemName: "flag")
                    Text("GuessTheFlag")
                }
            
            ViewAndModify()
                .tabItem {
                    Image(systemName: "lasso")
                    Text("ViewAndModify")
                }
        }
    }
}

struct WeSplit: View {
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
    var totalAmount: Double{
        _ = Double(numberOfPeople + 2)
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
                        Section("Select your tip"){
                            Picker("Tip percentage", selection: $tipPercentage){
                                ForEach(0..<101){
                                    Text("\($0)%")
                                    //Challenge 1 day 24 solution
                                        .foregroundStyle(tipPercentage == 0 ? .red : .black)
                                }
                            }
                            .pickerStyle(.navigationLink)
                        }
                        Section("Amount per person"){
                            Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))
                        }
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
struct FlagView: View{ //Challengue 2 day 24 solution
    var countries: [String]
    var number: Int

    var body: some View{
        Image(countries[number])
            .clipShape(.buttonBorder)
            .shadow(radius: 10)
    }
}

struct GuessTheFlag: View {
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State var counterScore = 0
    @State var counterQuestions = 1
    @State var finalScore = false
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 2), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            VStack{
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                VStack(spacing: 15){
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3){number in
                        Button{
                            flagTapped(number)
                        }label: {
                            FlagView(countries: countries, number: number) //Challengue 2 day 24 solution
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(counterScore)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore){
            Button("Continue", action: askQuestion)
        }message: {
            Text("Your score is \(counterScore)")
        }
        .alert("Game Over", isPresented: $finalScore){
            Button("Reset", action: resetGame)
        }message: {
            Text("Your score is \(counterScore) / 8")
        }
    }
    func flagTapped(_ number: Int){
        if number == correctAnswer{
            scoreTitle = "Correct"
            counterScore += 1
        }else{
            scoreTitle = "Wrong!, That's the flag of \(countries[number])"
        }
        if counterQuestions == 8 {
            finalScore = true
        }else{
            showingScore = true
        }
        counterQuestions += 1
    }
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    func resetGame(){
        counterScore = 0
        counterQuestions = 1
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct Title: ViewModifier{
    func body(content: Content) -> some View {
        content
            .font(.title)
            .foregroundColor(.blue)
            .padding()
            .background(.orange)
            .clipShape(.rect(cornerRadius: 20))
    }
}
extension View{
    func titleStyle ()-> some View{
        modifier(Title())
    }
}

struct WaterMark: ViewModifier{
    var text: String
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            
            Text(text)
                .font(.caption)
                .foregroundStyle(.white)
                .padding(5)
                .background(.gray)
                .cornerRadius(5)
        }
    }
}
extension View {
    func watermarked(with text: String) -> some View{
        modifier(WaterMark(text: text))
    }
}

struct GridStack<Content: View>: View{
    let rows: Int
    let columns: Int
    @ViewBuilder let content: (Int, Int) -> Content
    var body: some View{
        VStack{
            ForEach(0..<rows, id: \.self){ row in
                HStack{
                    ForEach(0..<columns, id: \.self){column in
                    content(row, column)
                    }
                }
            }
        }
    }
}

struct LargeViewTitle: ViewModifier{ //Challengue 3 day 24 solution
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue).bold()
            .padding()
    }
}
extension View { //Challengue 3 day 24 solution
    func largeViewTitle ()-> some View{
        modifier(LargeViewTitle())
    }
}

struct ViewAndModify: View {
    
    @State private var useRedText = true
    var body: some View {
        VStack{
            Text("Challenge 3 day 24") //Challengue 3 day 24 solution
                .largeViewTitle()
            Text("Modified Text")
                .titleStyle()
            Color.blue
                .frame(width: 300, height: 200)
                .cornerRadius(20)
                .watermarked(with: "By Manuel")
            GridStack(rows: 4, columns: 4){row, col in
                Image(systemName: "\(row * 4 + col).circle")
                Text("R\(row) C\(col)")
            }
        }
    }
}

#Preview {
    ContentView()
}
