//
//  Expenses.swift
//  Day59PaulHudsonSwiftDataProject
//
//  Created by Manuel Bermudo on 7/7/24.
//

import SwiftData
import Foundation

@Model
class Expenses {
    
    let name: String
    let type: String
    let amount: Double
    
    init(name: String, type: String, amount: Double) {
        self.name = name
        self.type = type
        self.amount = amount
    }
}
