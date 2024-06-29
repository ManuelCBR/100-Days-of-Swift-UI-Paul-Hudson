//
//  MoonshootView.swift
//  Day46PaulHudsonNavigation
//
//  Created by Manuel Bermudo on 25/6/24.
//

import SwiftUI

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
                    //Challenge 3
                    NavigationLink(value: mission){
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
                    //Challenge 3
                    .navigationDestination(for: Mission.self){mission in
                        MissionView(mission: mission, astronauts: astronauts)
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
                    //Challenge 3
                    NavigationLink(value: mission){
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
                    //Challenge 3
                    .navigationDestination(for: Mission.self){mission in
                        MissionView(mission: mission, astronauts: astronauts)
                    }
                }
                .listStyle(.plain)
                .background(.darkBackground)
                .navigationDestination(for: Mission.self){selection in
                    Text("Selected \(selection)")
                }
            }
            .navigationTitle("Moonshot")
        }
    }
}

struct MoonshootView: View {
    @State var toggleButton = "List"
    @State var showingGrid = true
    
    var body: some View {
        
        NavigationStack{
                Group {
                    if showingGrid {
                        MissionGridView()
                    } else {
                        MissionListView()
                    }
                }
            .preferredColorScheme(.dark)
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
    MoonshootView()
}
