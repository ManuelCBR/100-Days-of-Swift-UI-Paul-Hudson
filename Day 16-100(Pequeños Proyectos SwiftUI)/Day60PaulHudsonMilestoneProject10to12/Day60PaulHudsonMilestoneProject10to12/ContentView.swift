//
//  ContentView.swift
//  Day60PaulHudsonMilestoneProject10to12
//
//  Created by Manuel Bermudo on 9/7/24.
//

/**
 Challenge
 It’s time for you to build an app from scratch, and it’s a particularly expansive challenge today: your job is to use URLSession to download some JSON from the internet, use Codable to convert it to Swift types, then use NavigationStack, List, and more to display it to the user.

 Your first step should be to examine the JSON. The URL you want to use is this: https://www.hackingwithswift.com/samples/friendface.json – that’s a massive collection of randomly generated data for example users.

 As you can see, there is an array of people, and each person has an ID, name, age, email address, and more. They also have an array of tag strings, and an array of friends, where each friend has a name and ID.

 How far you implement this is down to you, but at the very least you should:

 Fetch the data and parse it into User and Friend structs.
 Display a list of users with a little information about them, such as their name and whether they are active right now.
 Create a detail view shown when a user is tapped, presenting more information about them, including the names of their friends.
 Before you start your download, check that your User array is empty so that you don’t keep starting the download every time the view is shown.
 */
import SwiftUI

struct User: Codable, Identifiable {
    var id: String
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: String
    var friends: [Friend]
    
    //Convert the registered String in a Date
    var registeredDate: Date? {
        ISO8601DateFormatter().date(from: registered)
    }
}
struct Friend: Codable, Identifiable {
    var id: String
    var name: String
}

struct ContentView: View {
    
    @State private var users = [User]()
    
    var body: some View {
        NavigationStack{
            List(users) {user in
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
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print ("Invalid URL")
            return
        }
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let decodedResponse = try? JSONDecoder().decode([User].self, from: data){
                users = decodedResponse.sorted { $0.name < $1.name } //Arranged in alphabetical order
            }
        }catch{
            print("Invalid data")
        }
    }
}

#Preview {
    ContentView()
}
