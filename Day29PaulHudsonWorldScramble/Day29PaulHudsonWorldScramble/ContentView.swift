//
//  ContentView.swift
//  Day29PaulHudsonWorldScramble
//
//  Created by Manuel Bermudo on 7/6/24.
//

import SwiftUI

struct ContentView: View {
    
    let people = ["Patricia", "Manuel", "Fatima"]
    
    var body: some View {
        List {
            Section("Static rows 1"){
                Text("Static row 1")
                Text("Static row 2")
            }
            Section("Dynamic rows"){
                ForEach (people, id: \.self) {
                    Text($0)
                }
            }

        }
        .listStyle(.grouped)
        List(people, id: \.self){
            Text($0)
        }
    }
    func testString(){
        let input = "a b c"
        let letters = input.components(separatedBy: " ")
        let input2 = """
                    a
                    b
                    c
                    """
        let letters2 = input2.components(separatedBy: "\n")
        let letter = letters2.randomElement()
        let trimmed = letter?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let word = "swift"
        let checker = UITextChecker()
        
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        let allGood = misspelledRange.location == NSNotFound
    }
    func testBundles(){
        if let fileURL = Bundle.main.url(forResource: "somefile", withExtension: "txt"){
            if let fileContents = try? String(contentsOf: fileURL){
                //We loaded the file into a string!
            }
        }
    }
}

#Preview {
    ContentView()
}
