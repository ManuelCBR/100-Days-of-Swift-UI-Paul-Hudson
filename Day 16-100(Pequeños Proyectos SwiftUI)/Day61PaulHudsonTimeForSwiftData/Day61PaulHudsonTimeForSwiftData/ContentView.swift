//
//  ContentView.swift
//  Day61PaulHudsonTimeForSwiftData
//
//  Created by Manuel Bermudo on 11/7/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    
    @Environment (\.modelContext) var modelContext
    @Query (sort: \User.name) var usersData: [User]
    
    var body: some View {
        NavigationStack{
            List(usersData) {user in
                NavigationLink{
                    DetailView(user: user)
                }label: {
                    VStack(alignment: .leading) {
                        Text(user.name)
                            .font(.headline)
                        Text("Age: \(user.age)")
                            .font(.subheadline)
                    }
                    .listRowBackground(Color.clear)
                }
            }
            .navigationTitle("Users")
            //Load the JSON in the background
            .task {
                await loadData()
            }
            .listStyle(.plain)
        }
    }
    // Function to load data from JSON
    func loadData() async {
        
        guard usersData.isEmpty else { return }

        do{
            guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
                print ("Invalid URL")
                return
            }
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decodedUser = try JSONDecoder().decode([User].self, from: data)
            
            for user in decodedUser {
                modelContext.insert(user)
            }
        }catch{
            print("Invalid data")
        }
    }
}

#Preview {
    do{
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: User.self, configurations: config)
        return ContentView()
            .modelContainer(container)
    }catch{
        return Text("Falied to create preview: \(error.localizedDescription)")
    }
}
