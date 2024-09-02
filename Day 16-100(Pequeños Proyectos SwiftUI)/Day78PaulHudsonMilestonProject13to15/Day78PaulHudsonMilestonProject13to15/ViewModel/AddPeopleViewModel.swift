//
//  AddPeopleVoewModel.swift
//  Day78PaulHudsonMilestonProject13to15
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
    @Published var latitude: Double = 0.0
    @Published var longitude: Double = 0.0
    
    private let locationFetcher = LocationFetcher()
    
    public init(people: People) {
            self.people = people
        locationFetcher.start()
    }
    
    func loadImage() {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else { return }
            self.imageData = imageData
        }
    }

    func save() {
        
        if let location = locationFetcher.lastKnownLocation {
            latitude = location.latitude
            longitude = location.longitude
        }
        
        if name.isEmpty || surname.isEmpty || role.isEmpty {
            showAlert = true
        } else {
            showAlert = false
            let person = Person(name: name, surname: surname, role: role, imageData: imageData, latitude: latitude, longitude: longitude)
            people.person.append(person)
        }
    }
    func removePerson(by id: UUID) {
        DispatchQueue.main.async {
            self.people.person.removeAll { $0.id == id }
        }
    }
}
