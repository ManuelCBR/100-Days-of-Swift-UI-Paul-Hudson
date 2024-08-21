//
//  ContentView.swift
//  Day77PaulHudsonMilestonProject13to15
//
//  Created by Manuel Bermudo on 20/8/24.
//

/**
 Challenge
 Have you ever been to a conference or a meetup, chatted to someone new, then realized seconds after you walk away that you’ve already forgotten their name? You’re not alone, and the app you’re building today will help solve that problem and others like it.
 Your goal is to build an app that asks users to import a picture from their photo library, then attach a name to whatever they imported. The full collection of pictures they name should be shown in a List, and tapping an item in the list should show a detail screen with a larger version of the picture.
 */

import PhotosUI
import SwiftUI

struct ContentView: View {
    
    @StateObject var addPeopleViewModel = AddPeopleViewModel(people: People())
    @State private var showingAddPerson = false
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationStack{
            ScrollView{
                LazyVGrid(columns: columns) {
                    ForEach(addPeopleViewModel.people.person) { person in
                        NavigationLink{
                            PersonView(person: person)
                        } label: {
                            VStack{
                                if let imageData = person.imageData, let uiImage = UIImage(data: imageData) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 170, height: 170)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .contextMenu {
                                            Button(role: .destructive) {
                                                addPeopleViewModel.removePerson(by: person.id)
                                            } label: {
                                                Label("Delete", systemImage: "trash")
                                            }
                                        }
                                } else {
                                    Image(systemName: "person.crop.circle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundStyle(Color.secondary)
                                        .frame(width: 170, height: 170)
                                        .contextMenu {
                                            Button(role: .destructive) {
                                                addPeopleViewModel.removePerson(by: person.id)
                                            } label: {
                                                Label("Delete", systemImage: "trash")
                                            }
                                        }
                                }
                            }
                        }
                    }
                }
                .padding([.horizontal, .bottom, .top])
            }
            .navigationTitle("People List")
            .toolbar{
                Button("Add Person", systemImage: "plus"){
                    showingAddPerson = true
                }
            }
            .sheet(isPresented: $showingAddPerson){
                AddPeopleView(addPeopleViewModel: addPeopleViewModel, people: People())
            }
        }
    }
}

#Preview {
    ContentView(addPeopleViewModel: AddPeopleViewModel(people: People()))
}
