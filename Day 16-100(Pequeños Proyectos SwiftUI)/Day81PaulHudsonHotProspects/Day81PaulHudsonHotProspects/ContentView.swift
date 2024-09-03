//
//  ContentView.swift
//  Day81PaulHudsonHotProspects
//
//  Created by Manuel Bermudo on 3/9/24.
//

import SamplePackage
import SwiftUI
import UserNotifications

struct ContentView: View {
    
    let possiblenumbers = 1...60
    
    var results: String {
        let selected = possiblenumbers.random(7).sorted()
        let strings = selected.map(String.init)
        return strings.formatted()
    }
    
    var body: some View {
        List{
            Section("Custom row swipe actions"){
                Text("Option 1")
                    .swipeActions{
                        Button("Delete", systemImage: "minus.circle", role: .destructive){print("Delete")}
                        Button("Send message", systemImage: "message"){print("Hi")}
                    }
                    .swipeActions(edge: .leading){
                        Button("Pin", systemImage: "pin"){print("Pinning")}.tint(.orange)
                    }
            }
        }
        VStack{
            Text("Lottery")
                .underline()
                .bold()
                .padding()
            Text(results)
            Spacer()
            Rectangle()
                .frame(height: 2)
            Text("Scheduling local notifications")
                .underline()
                .bold()
                .padding()
            Button("Request Permission"){
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]){success, error in
                    if success {
                        print("All set")
                    } else if let error {
                        print(error.localizedDescription)
                    }
                }
            }
            Button("Schedule Notification"){
                let content = UNMutableNotificationContent()
                content.title = "Feed the cat"
                content.subtitle = "It looks hungry"
                content.sound = UNNotificationSound.default
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request)
            }
            Spacer()
        }
    }
}

#Preview {
    ContentView()
}
