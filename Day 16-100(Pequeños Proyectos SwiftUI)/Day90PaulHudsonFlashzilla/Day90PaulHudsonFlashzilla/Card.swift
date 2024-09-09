//
//  Card.swift
//  Day90PaulHudsonFlashzilla
//
//  Created by Manuel Bermudo on 9/9/24.
//

import Foundation

struct Card: Codable {
    var prompt: String
    var answer: String
    
    static let example = Card(prompt: "Who played the 13th doctor in Doctor Who?", answer: "Jode Wittaker")
}
