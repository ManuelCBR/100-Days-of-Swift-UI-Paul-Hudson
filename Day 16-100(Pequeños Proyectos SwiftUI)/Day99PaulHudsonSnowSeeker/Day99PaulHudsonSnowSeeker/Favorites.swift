//
//  Favorites.swift
//  Day99PaulHudsonSnowSeeker
//
//  Created by Manuel Bermudo on 11/3/25.
//

import SwiftUI

@Observable
class Favorites {
    private var resorts: Set<String>
    private let key = "Favorites"
    
    init() {
        // load our saved data (Challenge 2)
        if let savedData = UserDefaults.standard.data(forKey: key) {
            if let decodedResorts = try? JSONDecoder().decode(Set<String>.self, from: savedData) {
                self.resorts = decodedResorts
                return
            }
        }
        // If data is empty
        self.resorts = []
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        // Save Favorites (Challenge 2)
        if let encoded = try? JSONEncoder().encode(resorts) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
        
    }
}

