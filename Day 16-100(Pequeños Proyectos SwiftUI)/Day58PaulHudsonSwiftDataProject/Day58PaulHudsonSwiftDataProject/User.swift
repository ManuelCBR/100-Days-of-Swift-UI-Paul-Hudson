//
//  User.swift
//  Day58PaulHudsonSwiftDataProject
//
//  Created by Manuel Bermudo on 5/7/24.
//

import SwiftData
import Foundation

@Model
class User {
    var name: String
    var city: String
    var joinDate: Date
    @Relationship(deleteRule: .cascade) var jobs = [Job]()
    
    init(name: String, city: String, joinDate: Date) {
        self.name = name
        self.city = city
        self.joinDate = joinDate
    }
}
