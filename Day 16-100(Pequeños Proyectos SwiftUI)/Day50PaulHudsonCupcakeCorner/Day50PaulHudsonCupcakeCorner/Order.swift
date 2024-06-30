//
//  Order.swift
//  Day50PaulHudsonCupcakeCorner
//
//  Created by Manuel Bermudo on 30/6/24.
//

import Foundation
@Observable
class Order {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet{
            if specialRequestEnabled == false {
                extraFrostring = false
                addSprinkles = false
            }
        }
    }
    var extraFrostring = false
    var addSprinkles = false
}
