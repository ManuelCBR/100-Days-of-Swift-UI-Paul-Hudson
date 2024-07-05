//
//  ContentView.swift
//  Day57PaulHudsonSwiftDataProject
//
//  Created by Manuel Bermudo on 4/7/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment (\.modelContext) var modelContext
    @Query(filter: #Predicate<User>{user in
        if user.name.localizedStandardContains("R"){
            if user.city == "London" {
                return true
            }else{
                return false
            }
        }else {
            return false
        }
        
    }, sort: \User.name) var users: [User]
    
    var body: some View {
        NavigationStack{
            List(users){ user in
                Text(user.name)
            }
            .navigationTitle("Users")
            .toolbar{
                Button("Add Samples", systemImage: "plus"){
                    
                    try? modelContext.delete(model: User.self)
                    
                    let first = User(name: "Manuel", city: "Seville", joinDate: .now.addingTimeInterval(86400 * -10))
                    let second = User(name: "Patricia", city: "Fuerteventura", joinDate: .now.addingTimeInterval(86400 * -5))
                    let third = User(name: "Roy Kent", city: "London", joinDate: .now.addingTimeInterval(86400 * 5))
                    let fourth = User(name: "Johnny English", city: "London", joinDate: .now.addingTimeInterval(86400 * 10))
                    
                    modelContext.insert(first)
                    modelContext.insert(second)
                    modelContext.insert(third)
                    modelContext.insert(fourth)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
