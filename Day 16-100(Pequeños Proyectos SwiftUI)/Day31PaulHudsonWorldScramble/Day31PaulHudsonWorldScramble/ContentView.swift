//
//  ContentView.swift
//  Day31PaulHudsonWorldScramble
//
//  Created by Manuel Bermudo on 9/6/24.
//

import SwiftUI

/**
 One of the best ways to learn is to write your own code as often as possible, so here are three ways you should try extending this app to make sure you fully understand what’s going on:

 - 1. Disallow answers that are shorter than three letters or are just our start word.
 - 2. Add a toolbar button that calls startGame(), so users can restart with a new word whenever they want to.
 - 3. Put a text view somewhere so you can track and show the player’s score for a given root word. How you calculate            score is down to you, but something involving number of words and their letter count would be reasonable.
 */

struct ContentView: View {
    
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        NavigationStack{
            List{
                Section{
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                }
                Section{
                    ForEach(usedWords, id: \.self){word in
                        HStack{
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                        //Accessibility day 75
                        .accessibilityElement()
                        .accessibilityLabel(word)
                        .accessibilityHint("\(word.count) letters")
                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showingError) { } message: {
                Text(errorMessage)
            }
            //Challenge 2
            .toolbar {
                Button("Restart"){
                    startGame()
                    usedWords.removeAll()
                }
            }
            //Challenge 3
            Text("Score")
                .font(.largeTitle)
                .foregroundStyle(.orange)
            VStack(alignment: .center){
                Text("(Number of total letters x by")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Text("the total number of words)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
                
            Text("\(scoreCalculator(listWords: usedWords))")
                .font(.title)
                .foregroundStyle(.blue)
            Spacer()
        }
    }
    func addNewWord(){
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else {return}
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original!")
            return
        }
        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
            return
        }
        guard isReal(word: answer) else {
            wordError(title: "Word not recongnized", message: "You can't just make them up, you know!")
            return
        }
        withAnimation{
            //Challenge 1
           if answer.count < 3 {
                showingError = true
                wordError(title: "Word too Short", message: "Work harder!")
           } else if answer.contains(rootWord){
               showingError = true
               wordError(title: "Word is the same than the start word", message: "Work harder!")
           }else{
               usedWords.insert(answer, at: 0)
           }
            
        }
        newWord = ""
    }
    func startGame(){
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let startWords = try? String(contentsOf: startWordsURL){
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        fatalError("Could not load start.txt from bundle")
    }
    func isOriginal (word: String) -> Bool {
        !usedWords.contains(word)
    }
    func isPossible (word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter){
                tempWord.remove(at: pos)
            }else{
                return false
            }
        }
        return true
    }
    func isReal (word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    func wordError(title: String, message: String){
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    func isTooShort (word: String) -> Bool{
        showingError = word.count < 3 ? true : false
        return showingError
     
    }
    //Challenge 3
    func scoreCalculator (listWords: [String]) -> Int{

        let combinedString = listWords.joined(separator: "")
        let letters = combinedString.filter { $0.isLetter }
        let lettersCounter = letters.count
        let listCounter = listWords.count
        
        return listCounter * lettersCounter
    }
}

#Preview {
    ContentView()
}
