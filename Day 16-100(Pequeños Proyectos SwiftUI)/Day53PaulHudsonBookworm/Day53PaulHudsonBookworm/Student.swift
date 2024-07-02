//
//  Student.swift
//  Day53PaulHudsonBookworm
//
//  Created by Manuel Bermudo on 2/7/24.
//

import Foundation
import SwiftData

@Model
class Student {
    var id: UUID
    var name: String
    
    init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
}
