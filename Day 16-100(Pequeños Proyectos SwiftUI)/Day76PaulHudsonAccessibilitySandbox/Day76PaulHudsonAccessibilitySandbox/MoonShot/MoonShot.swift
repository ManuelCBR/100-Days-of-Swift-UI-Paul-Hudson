//
//  MoonShot.swift
//  Day76PaulHudsonAccessibilitySandbox
//
//  Created by Manuel Bermudo on 15/8/24.
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
                    NavigationLink{
                        MissionView(mission: mission, astronauts: astronauts)
                    }label: {
                        VStack{
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding()
                                //Challenge 3            
                                .accessibilityLabel("Image of mission \(mission.image)")
                            VStack{
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundStyle(.white)
                                    //Challenge 3
                                    .accessibilityHidden(true)
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
                                //Challenge 3
                                .accessibilityLabel("Image of mission \(mission.image)")
                            VStack{
                                Text(mission.displayName)
                                    .font(.title3.bold())
                                //Challenge 3
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

struct MoonShot: View {
    
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
                    //Challenge 3
                    .accessibilityLabel(showingGrid ? "Switch to list view" : "Switch to grid view")
                }
            }
        }
    }
}

#Preview {
    MoonShot()
}
