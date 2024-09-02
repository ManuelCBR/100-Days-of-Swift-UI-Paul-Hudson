//
//  ContentView.swift
//  Day78PaulHudsonMilestonProject13to15
//
//  Created by Manuel Bermudo on 21/8/24.
//
/**
 Yesterday you built a new app that imports photos from the user’s library, and hopefully you’re pleased with the finished product – or at least making great progress towards the finished product.
 But your boss has come in and demanded a new feature: when you’re viewing a picture that was imported, you should show a map with a pin that marks where they were when that picture was added. It might be on the same screen side by side with the photo, it might be shown or hidden using a segmented control, or perhaps it’s on a different screen – it’s down to you. Regardless, you know how to drop pins, and you also know how to use the center coordinate of map views, so the only thing left to figure out is how to get the user’s location to save alongside their text and image.
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
