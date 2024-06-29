//
//  ContentView.swift
//  Day22PaulHudsonGuessTheFlag
//
//  Created by Manuel Bermudo on 3/6/24.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    /**
     Challenge day 22:
     Add an @State property to store the user’s score, modify it when they get an answer right or wrong, then display it in the alert and in the score label.
     */
    @State var counterScore = 0
    /**
     Challenge day 22:
     Make the game show only 8 questions, at which point they see a final alert judging their score and can restart the game.
     */
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
                            Image(countries[number])
                                .clipShape(.buttonBorder)
                                .shadow(radius: 10)
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
        /**
         Challenge day 22:
         Make the game show only 8 questions, at which point they see a final alert judging their score and can restart the game.
         */
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
            /**
             Challenge day 22:
             When someone chooses the wrong flag, tell them their mistake in your alert message – something like “Wrong! That’s the flag of France,” for example.
             */
            scoreTitle = "Wrong!, That's the flag of \(countries[number])"
        }
        /**
         Challenge day 22:
         Make the game show only 8 questions, at which point they see a final alert judging their score and can restart the game.
         */
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
    /**
     Challenge day 22:
     Make the game show only 8 questions, at which point they see a final alert judging their score and can restart the game.
     */
    func resetGame(){
        counterScore = 0
        counterQuestions = 1
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

#Preview {
    ContentView()
}
