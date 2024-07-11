//
//  User.swift
//  Day61PaulHudsonTimeForSwiftData
//
//  Created by Manuel Bermudo on 11/7/24.
//

import Foundation
import SwiftData

@Model
class User: Codable, Identifiable {
    
    enum CodingKeys: CodingKey {
        case id, name, age, company, email, address, about, registered, friends
    }
    
    var id: String
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: String
    var friends: [Friend]
    
    //Convert the registered String in a Date
    var registeredDate: Date? {
        ISO8601DateFormatter().date(from: registered)
    }
    
    init(id: String, name: String, age: Int, company: String, email: String, address: String, about: String, registered: String, friends: [Friend]) {
           self.id = id
           self.name = name
           self.age = age
           self.company = company
           self.email = email
           self.address = address
           self.about = about
           self.registered = registered
           self.friends = friends
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.age = try container.decode(Int.self, forKey: .age)
        self.company = try container.decode(String.self, forKey: .company)
        self.email = try container.decode(String.self, forKey: .email)
        self.address = try container.decode(String.self, forKey: .address)
        self.about = try container.decode(String.self, forKey: .about)
        self.registered = try container.decode(String.self, forKey: .registered)
        self.friends = try container.decode([Friend].self, forKey: .friends)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.age, forKey: .age)
        try container.encode(self.company, forKey: .company)
        try container.encode(self.email, forKey: .email)
        try container.encode(self.address, forKey: .address)
        try container.encode(self.about, forKey: .about)
        try container.encode(self.registered, forKey: .registered)
        try container.encode(self.friends, forKey: .friends)
    }
}
