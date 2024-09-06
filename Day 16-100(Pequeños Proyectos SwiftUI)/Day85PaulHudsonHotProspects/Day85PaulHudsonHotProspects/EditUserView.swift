//
//  EditUserView.swift
//  Day85PaulHudsonHotProspects
//
//  Created by Manuel Bermudo on 6/9/24.
//

import SwiftData
import SwiftUI

//Challenge 2
struct EditUserView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @Bindable var prospect: Prospect
    
    var body: some View {
        Form{
            Section(){
                TextField("Name", text: $prospect.name)
                TextField("Email address", text: $prospect.emailAddress)
            }
        }
        .navigationTitle("Edit User")
        .toolbar {
            Button("Save"){
                do{
                    try modelContext.save()
                } catch {
                    print("\(error.localizedDescription)")
                }
                dismiss()
            }
        }
    }
}

#Preview {
    do{
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Prospect.self, configurations: config)
        let prospect = Prospect(name: "Name Test", emailAddress: "Email Test", isContacted: false, creationDate: Date())
        
        return EditUserView(prospect: prospect)
            .modelContainer(container)
    } catch {
        return Text("Failed to create container: \(error.localizedDescription)")
    }
}

