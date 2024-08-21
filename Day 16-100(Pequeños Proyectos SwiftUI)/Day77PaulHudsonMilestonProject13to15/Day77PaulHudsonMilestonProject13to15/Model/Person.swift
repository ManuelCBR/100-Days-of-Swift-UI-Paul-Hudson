//
//  Person.swift
//  Day77PaulHudsonMilestonProject13to15
//
//  Created by Manuel Bermudo on 21/8/24.
//

import Foundation
import SwiftUI

struct Person: Identifiable, Codable {
    var id = UUID()
    let name: String
    let surname: String
    let role: String
    let imageData: Data?
}
