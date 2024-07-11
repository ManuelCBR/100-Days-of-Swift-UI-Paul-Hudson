//
//  DetailView.swift
//  Day61PaulHudsonTimeForSwiftData
//
//  Created by Manuel Bermudo on 11/7/24.
//

import SwiftData
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
    do{
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: User.self, configurations: config)
        let example = User(id: "0", name: "Unknown", age: 0, company: "Unknown", email: "Unknown", address: "Unknown", about: "Unknown", registered: "Unknown", friends: [])
        return DetailView(user: example)
            .modelContainer(container)
    }catch{
        return Text("Falied to create preview: \(error.localizedDescription)")
    }
}
