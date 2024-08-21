//
//  AddPeopleViewModel.swift
//  Day77PaulHudsonMilestonProject13to15
//
//  Created by Manuel Bermudo on 21/8/24.
//


import Foundation
import PhotosUI
import SwiftUI

class AddPeopleViewModel: ObservableObject {
    
    @Published var name = ""
    @Published var surname = ""
    @Published var role = ""
    @Published var imageData: Data? = nil
    @Published var showAlert = false
    @Published var people: People
    @Published var selectedItem: PhotosPickerItem?
    
    public init(people: People) {
            self.people = people
    }
    
    func loadImage() {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else { return }
            self.imageData = imageData
        }
    }

    func save() {
        if name.isEmpty || surname.isEmpty || role.isEmpty {
            showAlert = true
        } else {
            showAlert = false
            let person = Person(name: name, surname: surname, role: role, imageData: imageData)
            people.person.append(person)
        }
    }
    func removePerson(by id: UUID) {
        DispatchQueue.main.async {
            self.people.person.removeAll { $0.id == id }
        }
    }
}
