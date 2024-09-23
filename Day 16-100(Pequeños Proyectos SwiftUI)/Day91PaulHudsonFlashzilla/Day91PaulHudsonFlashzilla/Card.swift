//
//  Card.swift
//  Day91PaulHudsonFlashzilla
//
//  Created by Manuel Bermudo on 11/9/24.
//

import Foundation
import SwiftData

@Model
class Card {
    var id: UUID
    var prompt: String
    var answer: String

    init(id: UUID, prompt: String, answer: String) {
        self.id = id
        self.prompt = prompt
        self.answer = answer
    }
}
