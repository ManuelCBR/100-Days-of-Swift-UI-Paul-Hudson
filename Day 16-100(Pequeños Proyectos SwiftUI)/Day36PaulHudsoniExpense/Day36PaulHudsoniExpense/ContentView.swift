//
//  ContentView.swift
//  Day36PaulHudsoniExpense
//
//  Created by Manuel Bermudo on 17/6/24.
//
import Observation
import SwiftUI

@Observable
class User{
    var fistsName = "Steven"
    var secondName = "Strange"
}

struct SecondView: View {
    
    @Environment(\.dismiss) var dismiss
    let name: String
    
    var body: some View {
        Text("Hello, \(name)")
        Button("Dismiss"){
            dismiss()
        }
    }
}

struct CodableUser: Codable {
    let firstName: String
    let secondName: String
}

struct ContentView: View {
    
    @State private var user = User()
    @State private var showingSheet = false
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    @AppStorage("tapCount") private var tapCount = 0
    @State private var codableUser = CodableUser(firstName: "Steven", secondName: "Strange")
    
    var body: some View {
        NavigationStack{
            VStack {
                Text("Your name is \(user.fistsName) \(user.secondName)")
                TextField("First name", text: $user.fistsName)
                TextField("Second name", text: $user.secondName)
            }
            Button("Show the sheet") {
                showingSheet.toggle()
            }
            .sheet(isPresented: $showingSheet) {
                SecondView(name: "Manuel")
            }
            List{
                ForEach (numbers, id: \.self) {
                    Text("Row \($0)")
                }
                .onDelete(perform: removeRows)
            }
            HStack{
                Button("Add number") {
                    numbers.append(currentNumber)
                    currentNumber += 1
                }
                Spacer()
                    .frame(width: 30)
                Button("Tap Count \(tapCount)") {
                   tapCount += 1
                }
                Spacer()
                    .frame(width: 30)
                Button("Save User") {
                   let encoder = JSONEncoder()
                    if let data = try? encoder.encode(codableUser){
                        UserDefaults.standard.set(data, forKey: "UserData")
                    }
                }
            }
            .toolbar{
                EditButton()
            }
        }
    }
    func removeRows (at offsets: IndexSet){
        numbers.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
