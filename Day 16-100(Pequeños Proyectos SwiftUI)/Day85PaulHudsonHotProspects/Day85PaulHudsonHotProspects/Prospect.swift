//
//  Prospect.swift
//  Day85PaulHudsonHotProspects
//
//  Created by Manuel Bermudo on 5/9/24.
//

import Foundation
import SwiftData

@Model
class Prospect {
    var name: String
    var emailAddress: String
    var isContacted: Bool
    var creationDate: Date
    
    init(name: String, emailAddress: String, isContacted: Bool, creationDate: Date = Date()) {
        self.name = name
        self.emailAddress = emailAddress
        self.isContacted = isContacted
        self.creationDate = creationDate
    }
}
