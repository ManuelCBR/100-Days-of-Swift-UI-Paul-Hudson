//
//  Order.swift
//  Day76PaulHudsonAccessibilitySandbox
//
//  Created by Manuel Bermudo on 15/8/24.
//

import Foundation

extension String {
    var isValidField: Bool {
        let trimmedString = self.trimmingCharacters(in: .whitespacesAndNewlines)
        return !trimmedString.isEmpty
    }
}

@Observable
class Order: Codable {

    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _city = "city"
        case _streetAddress = "streetAddress"
        case _zip = "zip"
    }
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet{
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAdress: Bool {

        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }
        
        if !name.isValidField || !streetAddress.isValidField || !city.isValidField || !zip.isValidField {
            return false
        }
        return true
    }
    var cost: Decimal {
        // 2€ per cake
        var cost = Decimal(quantity) * 2
        
        // Complicated cakes cost more
        cost += Decimal(type) / 2
        
        // 1€/cake for extra frosting
        if extraFrosting {
            cost += Decimal(quantity)
        }
        // 0.50€/Cake for sprinkles
        if addSprinkles {
            cost += Decimal(quantity) / 2
        }
        return cost
    }
    func saveUserOrder (){
        UserDefaults.standard.set(name, forKey: "name")
        UserDefaults.standard.set(streetAddress, forKey: "streetAddress")
        UserDefaults.standard.set(city, forKey: "city")
        UserDefaults.standard.set(zip, forKey: "zip")
    }
    func loadUserOrder (){
        name = UserDefaults.standard.string(forKey: "name") ?? ""
        streetAddress = UserDefaults.standard.string(forKey: "streetAddress") ?? ""
        city = UserDefaults.standard.string(forKey: "city") ?? ""
        zip = UserDefaults.standard.string(forKey: "zip") ?? ""
    }
}
