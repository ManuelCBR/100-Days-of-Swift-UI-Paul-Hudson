//
//  ContentView.swift
//  Day34PaulHudsonAnimations
//
//  Created by Manuel Bermudo on 10/6/24.
//

import SwiftUI

/**
 Challenge
 One of the best ways to learn is to write your own code as often as possible, so here are three ways you should try extending this app to make sure you fully understand what’s going on.
 Go back to the Guess the Flag project and add some animation:
 - 1. When you tap a flag, make it spin around 360 degrees on the Y axis.
 - 2.  Make the other two buttons fade out to 25% opacity.
 - 3. Add a third effect of your choosing to the two flags the user didn’t choose – maybe make them scale down? Or flip in a different direction? Experiment!
 */

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State var counterScore = 0
    @State var counterQuestions = 1
    @State var finalScore = false
    @State var selectedFlag: Int? = nil
    
    @State private var animationAmount3D = [0.0, 0.0, 0.0]
    
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
                            //Challenge 1
                            withAnimation(.spring(duration: 1, bounce: 0.5)){
                                animationAmount3D[number] += 360
                            }
                        }label: {
                            Image(countries[number])
                                .clipShape(.buttonBorder)
                                .shadow(radius: 10)
                        }
                        //Challenge 1
                        .rotation3DEffect(.degrees(animationAmount3D[number]), axis: (x: 1.0, y: 0.0, z: 0.0))
                        //Challenge 2
                        .opacity(selectedFlag == nil || selectedFlag == number ? 1 : 0.25)
                        //Challenge 3
                        .scaleEffect(selectedFlag == nil || selectedFlag == number ? 1 : 0.65)
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
        selectedFlag = number
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
        selectedFlag = nil
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    func resetGame(){
        selectedFlag = nil
        counterScore = 0
        counterQuestions = 1
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}


#Preview {
    ContentView()
}
