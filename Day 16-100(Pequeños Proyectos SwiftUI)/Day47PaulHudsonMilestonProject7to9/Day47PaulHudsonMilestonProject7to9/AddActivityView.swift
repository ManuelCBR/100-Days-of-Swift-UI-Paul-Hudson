//
//  AddActivityView.swift
//  Day47PaulHudsonMilestonProject7to9
//
//  Created by Manuel Bermudo on 26/6/24.
//

import SwiftUI

struct AddActivityView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var description = ""
    
    var activities: Activities
    
    var body: some View {
        NavigationStack{
            ZStack{
                LinearGradient(colors: [.yellow, .orange], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                Form{
                    TextField("Name", text: $name)
                        .listRowBackground(Color(#colorLiteral(red: 1, green: 0.6632267833, blue: 0, alpha: 1)))
                    TextField("Description", text: $description)
                        .listRowBackground(Color(#colorLiteral(red: 1, green: 0.6632267833, blue: 0, alpha: 1)))
                        
                }
                .scrollContentBackground(.hidden)
                .navigationTitle("Add your activity")
                .toolbar{
                    Button("Save"){
                        let activity = Activity(name: name, description: description)
                        activities.activities.append(activity)
                        dismiss()
                    }
                    .foregroundStyle(Color(#colorLiteral(red: 1, green: 0.2969147265, blue: 0, alpha: 1)))
                    
                }
            }
            .preferredColorScheme(.light)
        }
    }
}

#Preview {
    AddActivityView(activities: Activities())
}
