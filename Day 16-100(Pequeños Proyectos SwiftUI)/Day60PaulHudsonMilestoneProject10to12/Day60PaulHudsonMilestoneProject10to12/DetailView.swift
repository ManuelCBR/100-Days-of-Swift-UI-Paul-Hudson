//
//  DetailView.swift
//  Day60PaulHudsonMilestoneProject10to12
//
//  Created by Manuel Bermudo on 10/7/24.
//

import SwiftUI

struct DetailView: View {
    
    var user: User
    
    // Required date format
    private var dateFormatter: DateFormatter{
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }
    
    var body: some View {
        NavigationStack{
            List{
                Section("Age"){
                    Text("\(user.age) years old")
                }
                Section("Company"){
                    Text(user.company)
                }
                Section("Registered"){
                    Text("\(user.registeredDate ?? .now, formatter: dateFormatter)")
                }
                Section("Email"){
                    Text(user.email)
                }
                Section("Address"){
                    Text(user.address)
                }
                Section("About"){
                    Text(user.about)
                }
                Section("Friends"){
                    ForEach(user.friends){friends in
                        Text(friends.name)
                    }
                }
            }
            .navigationTitle(user.name)
        }
    }
}

#Preview {
    DetailView(user: User(id: "ID", name: "Unknown", age: 0, company: "Unknown", email: "Unknown", address: "Unknown" , about: "About",registered: "", friends: []))
}
