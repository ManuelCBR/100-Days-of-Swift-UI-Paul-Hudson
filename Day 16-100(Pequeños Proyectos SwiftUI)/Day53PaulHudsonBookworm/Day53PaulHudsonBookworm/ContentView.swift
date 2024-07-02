//
//  ContentView.swift
//  Day53PaulHudsonBookworm
//
//  Created by Manuel Bermudo on 2/7/24.
//

import SwiftData
import SwiftUI

struct PushButton: View {
    
    let title: String
    
    @Binding var isOn: Bool
    
    var onColors = [Color.red, Color.yellow]
    var offColors = [Color(white: 0.6), Color(white: 0.4)]
    
    var body: some View {
        Button(title){
            isOn.toggle()
        }
        .padding()
        .background(LinearGradient(colors: isOn ? onColors : offColors, startPoint: .top, endPoint: .bottom))
        .foregroundColor(.white)
        .clipShape(.capsule)
        .shadow(radius: isOn ? 0 : 5)
    }
}

struct ContentView: View {
    
    @State private var rememberMe = false
    @AppStorage("notes") private var notes = ""
    @Environment(\.modelContext) var modelContext
    @Query var students: [Student]
    
    var body: some View {
        VStack {
            PushButton(title: "Remember me", isOn: $rememberMe)
            Text(rememberMe ? "On" : "Off")
            NavigationStack{
                List(students){student in
                    Text(student.name)
                }
                .navigationTitle("Classroom")
                .toolbar{
                    Button("Add"){
                        let firstName = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
                        let lastNames = ["Granger", "Lovegood", "Potter", "Weasley"]
                        
                        let chosenFirstName = firstName.randomElement()!
                        let chosenLastName = lastNames.randomElement()!
                        
                        let student = Student(id: UUID(), name: "\(chosenFirstName) \(chosenLastName)")
                        modelContext.insert(student)
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
