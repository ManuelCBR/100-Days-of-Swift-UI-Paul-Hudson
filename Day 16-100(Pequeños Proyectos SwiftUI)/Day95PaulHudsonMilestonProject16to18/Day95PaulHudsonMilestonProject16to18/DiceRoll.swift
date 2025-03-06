//
//  DiceRoll.swift
//  Day95PaulHudsonMilestonProject16to18
//
//  Created by Manuel Bermudo on 7/1/25.
//

import Foundation
import SwiftData

@Model
class DiceRoll {
    var id: UUID
    var result: String
    var plus: Int
    
    init(id: UUID, result: String, plus: Int) {
        self.id = id
        self.result = result
        self.plus = plus
    }
}
