//
//  People.swift
//  Day77PaulHudsonMilestonProject13to15
//
//  Created by Manuel Bermudo on 20/8/24.
//

import Foundation

@Observable
class People {
    var person = [Person](){
        didSet {
            if let encoded = try? JSONEncoder().encode(person){
                UserDefaults.standard.set(encoded, forKey: "People")
            }
        }
    }
    init(){
        if let savedPeople = UserDefaults.standard.data(forKey: "People"){
            if let decodedPeople = try? JSONDecoder().decode([Person].self, from: savedPeople){
                person = decodedPeople
                return
            }
        }
        person = []
    }
}
