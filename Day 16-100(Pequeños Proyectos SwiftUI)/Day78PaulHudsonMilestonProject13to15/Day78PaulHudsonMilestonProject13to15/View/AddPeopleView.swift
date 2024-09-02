//
//  AddPeopleView.swift
//  Day78PaulHudsonMilestonProject13to15
//
//  Created by Manuel Bermudo on 21/8/24.
//

import PhotosUI
import SwiftUI

struct AddPeopleView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var addPeopleViewModel: AddPeopleViewModel
    
    let locationFetcher = LocationFetcher()

    var people: People
    
    var body: some View {
        NavigationStack{
            List {
                Section{
                    TextField ("Name", text: $addPeopleViewModel.name)
                    TextField ("Surname", text: $addPeopleViewModel.surname)
                    TextField ("Role", text: $addPeopleViewModel.role)
                }
                Section ("Select a picture"){
                    PhotosPicker(selection: $addPeopleViewModel.selectedItem){
                        if let imageData = addPeopleViewModel.imageData, let uiImage = UIImage(data: imageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                        } else {
                            ContentUnavailableView("No picture", systemImage: "photo.badge.plus", description: Text("Tap to import a photo"))
                        }
                    }
                    .buttonStyle(.plain)
                    .onChange(of: addPeopleViewModel.selectedItem, addPeopleViewModel.loadImage)
                }
            }
            .navigationTitle("Add person")
            .toolbar{
                Button("Save"){
                    addPeopleViewModel.save()
                    if !addPeopleViewModel.showAlert {
                        dismiss()
                    }
                }
            }
            .alert(isPresented: $addPeopleViewModel.showAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text("You must complete all fields")
                )
            }
            .onDisappear {
                        // Reinicia los campos cuando la hoja desaparece
                addPeopleViewModel.name = ""
                addPeopleViewModel.surname = ""
                addPeopleViewModel.role = ""
                addPeopleViewModel.imageData = nil
            }
        }
    }
}

#Preview {
    AddPeopleView(addPeopleViewModel: AddPeopleViewModel(people: People()), people: People())
}
