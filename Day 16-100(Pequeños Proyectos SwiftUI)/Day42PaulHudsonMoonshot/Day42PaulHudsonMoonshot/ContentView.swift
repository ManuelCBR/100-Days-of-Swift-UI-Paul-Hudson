//
//  ContentView.swift
//  Day42PaulHudsonMoonshot
//
//  Created by Manuel Bermudo on 22/6/24.
//

import SwiftUI

/**
 Challenge
 One of the best ways to learn is to write your own code as often as possible, so here are three ways you should try extending this app to make sure you fully understand what’s going on.

 - 1. Add the launch date to MissionView, below the mission badge. You might choose to format this differently given that more space is available, but it’s down to you.
 - 2. Extract one or two pieces of view code into their own new SwiftUI views – the horizontal scroll view in MissionView is a great candidate, but if you followed my styling then you could also move the Rectangle dividers out too.
 - 3. For a tough challenge, add a toolbar item to ContentView that toggles between showing missions as a grid and as a list.
 */
//Challenge 3
struct MissionGridView: View {
    
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        ScrollView{
            LazyVGrid(columns: columns) {
                ForEach(missions) { mission in
                    NavigationLink{
                        MissionView(mission: mission, astronauts: astronauts)
                    }label: {
                        VStack{
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding()
                            VStack{
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundStyle(.white)
                                Text(mission.formattedLaunchDate)
                                    .font(.caption)
                                    .foregroundStyle(.white.opacity(0.5))
                            }
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(.lightBackground)
                        }
                        .clipShape(.rect(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.lightBackground)
                        )
                    }
                }
            }
            .padding([.horizontal, .bottom])
        }
        .navigationTitle("Moonshot")
        .background(.darkBackground)
        .preferredColorScheme(.dark)
    }
}
//Challenge 3
struct MissionListView: View {
    
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationStack {
            VStack{
                List(missions){mission in
                    NavigationLink{
                        MissionView(mission: mission, astronauts: astronauts)
                    }label:{
                        HStack{
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                            VStack{
                                Text(mission.displayName)
                                    .font(.title3.bold())
                                Text(mission.formattedLaunchDate)
                                    .font(.caption)
                            }
                        }
    
                    }
                    .listRowBackground(Color.clear)
                   
                }
                .listStyle(.plain)
                .background(.darkBackground)
            }
            .navigationTitle("Moonshot")
            
        }
       
    }
}

struct ContentView: View {
    
    @State var toggleButton = "List"
    @State var showingGrid = true
    
    var body: some View {
        
        NavigationStack{
                //Challenge 3
                Group {
                    if showingGrid {
                        MissionGridView()
                    } else {
                        MissionListView()
                    }
                }
            .preferredColorScheme(.dark)
            //Challenge 3
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button(action: {
                        showingGrid.toggle()
                    }) {
                        Image (systemName: showingGrid ? "list.bullet" : "square.grid.2x2")
                            .imageScale(.large)
                            .foregroundStyle(.white)
                            .padding(.trailing)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
