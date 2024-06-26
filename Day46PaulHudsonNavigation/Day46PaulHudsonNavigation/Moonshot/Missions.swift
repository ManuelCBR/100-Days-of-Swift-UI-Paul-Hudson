//
//  Missions.swift
//  Day46PaulHudsonNavigation
//
//  Created by Manuel Bermudo on 25/6/24.
//

import Foundation

struct Mission: Codable, Hashable, Identifiable {
    
    struct CrewRole: Codable, Hashable{
        let name: String
        let role: String
    }
    
    
    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    var displayName: String{
        "Apollo \(id)"
    }
    var image: String{
        "apollo\(id)"
    }
    var formattedLaunchDate: String{
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
    //Challenge 1
    var completeFormattedLaunchDate: String{
        launchDate?.formatted(date: .complete, time: .omitted) ?? "N/A"
    }
    
}
