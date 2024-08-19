//
//  MissionView.swift
//  Day76PaulHudsonAccessibilitySandbox
//
//  Created by Manuel Bermudo on 15/8/24.
//

import SwiftUI

struct HorizontalScroll: View {
    let crew: [MissionView.CrewMember]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
                ForEach(crew, id: \.role) { crewMember in
                    NavigationLink{
                        AstronautView(astronaut: crewMember.astronaut)
                    }label:{
                        HStack{
                            Image(crewMember.astronaut.id)
                                .resizable()
                                .frame(width: 110, height: 75)
                                .clipShape(.capsule)
                                .overlay(
                                    Capsule()
                                        .strokeBorder(.lightBackground, lineWidth: 2)
                                )
                            VStack{
                                Text(crewMember.astronaut.name)
                                    .foregroundStyle(.white)
                                    .font(.headline)
                                Text(crewMember.role)
                                    .foregroundStyle(.white.opacity(0.5))
                            }
                        }
                        //Challenge 3
                        .accessibilityElement(children: .ignore)
                        .accessibilityLabel("Astronaut \(crewMember.astronaut.name), \(crewMember.role)")
                        .accessibilityAddTraits(.isButton)
                    }
                }
            }
        }
    }
}
struct RectangleDivider: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundColor(.lightBackground)
            .padding(.vertical)
    }
}

struct MissionView: View {
    
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    let mission: Mission
    let crew: [CrewMember]
    
    var body: some View {
        ScrollView{
            VStack{
                VStack{
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .containerRelativeFrame(.horizontal){width, axis in
                            width * 0.6
                        }
                    Text(mission.completeFormattedLaunchDate)
                        .font(.headline)
                        .padding(.top, 10)
                }
                .accessibilityElement(children: .ignore)
                .accessibilityLabel("Image of mission \(mission.image), \(mission.completeFormattedLaunchDate)")
                VStack(alignment: .leading){
                    RectangleDivider()
                    Text("Missions Highlights")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                    Text(mission.description)
                    RectangleDivider()
                    Text("Crew")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                }
                .padding(.horizontal)
                HorizontalScroll(crew: crew)
            }
        }
        .background(.darkBackground)
        .preferredColorScheme(.dark)
    }
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        self.crew = mission.crew.map{member in
            if let astronaut = astronauts[member.name]{
                return CrewMember(role: member.role, astronaut: astronaut)
            }else{
                fatalError("Missing \(member.name)")
            }
        }
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    return MissionView(mission: missions[0], astronauts: astronauts)
}
