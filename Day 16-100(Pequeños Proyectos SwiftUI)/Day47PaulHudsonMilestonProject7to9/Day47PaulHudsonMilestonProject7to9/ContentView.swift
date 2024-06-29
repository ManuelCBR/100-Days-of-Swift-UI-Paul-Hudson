//
//  ContentView.swift
//  Day47PaulHudsonMilestonProject7to9
//
//  Created by Manuel Bermudo on 26/6/24.
//

import SwiftUI

/**
 This time your goal is to build a habit-tracking app, for folks who want to keep track of how much they do certain things. That might be learning a language, practicing an instrument, exercising, or whatever – they get to decide which activities they add, and track it however they want.
 
 At the very least, this means there should be a list of all activities they want to track, plus a form to add new activities – a title and description should be enough.

 For a bigger challenge, tapping one of the activities should show a detail screen with the description. 
 For a tough challenge – see the hints below! – make that detail screen contain how many times they have completed it, plus a button incrementing their completion count.
 */

struct Activity: Identifiable, Codable, Equatable {
    var id = UUID()
    let name: String
    let description: String
    var completionCount: Int = 1
}

@Observable
class Activities {
    var activities = [Activity](){
        didSet{
            if let encoded = try? JSONEncoder().encode(activities){
                UserDefaults.standard.set(encoded, forKey: "activities")
            }
        }
    }
    init(){
        if let savedActivites = UserDefaults.standard.data(forKey: "activities"){
            if let decodedActivities = try? JSONDecoder().decode([Activity].self, from: savedActivites){
                activities = decodedActivities
                return
            }
        }
        activities = []
    }
}

struct ContentView: View {
    
    @State private var activities = Activities()
    @State private var showingAddActivity = false
    
    var body: some View {
        NavigationStack{
            VStack{
                List{
                    ForEach(activities.activities){activity in
                        NavigationLink{
                            DescriptionActivityView(activities: activities, descriptions: activity)
                        }label:{
                            HStack{
                                Text(activity.name)
                                    .font(.headline)
                                Image(systemName: "\(activity.completionCount).circle")
                                    .padding(.leading, 30)
                            }
                        }
                        .listRowBackground(Color.clear)
                    }
                    .onDelete(perform: removeActivities)
                }
                .toolbarBackground(Color.yellow)
                .navigationTitle("Activities")
                .toolbar{
                    Button(action: {
                        showingAddActivity = true
                    }) {
                        Image(systemName: "plus")
                            .foregroundColor(Color(#colorLiteral(red: 1, green: 0.2969147265, blue: 0, alpha: 1)))
                    }
                }
                .listStyle(.plain)
                .background(LinearGradient(colors: [.yellow, .orange], startPoint: .top, endPoint: .bottom))
                .sheet(isPresented: $showingAddActivity, content: {
                    AddActivityView(activities: activities)
                })
            }
            .preferredColorScheme(.light)
        }
    }
    func removeActivities (at offsets: IndexSet){
        activities.activities.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
