//
//  Person.swift
//  Day78PaulHudsonMilestonProject13to15
//
//  Created by Manuel Bermudo on 21/8/24.
//

import CoreLocation
import Foundation
import SwiftUI

struct Person: Identifiable, Codable {
    var id = UUID()
    let name: String
    let surname: String
    let role: String
    let imageData: Data?
    var latitude: Double
    var longitude: Double
}
