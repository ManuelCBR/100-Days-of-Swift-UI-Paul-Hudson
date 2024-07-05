//
//  User.swift
//  Day57PaulHudsonSwiftDataProject
//
//  Created by Manuel Bermudo on 4/7/24.
//

import SwiftData
import Foundation

@Model
class User {
    var name: String
    var city: String
    var joinDate: Date
    
    init(name: String, city: String, joinDate: Date) {
        self.name = name
        self.city = city
        self.joinDate = joinDate
    } 
}
