//
//  ContentView-ViewModel.swift
//  Day73PaulHudsonBucketList
//
//  Created by Manuel Bermudo on 6/8/24.
//

import CoreLocation
import Foundation
import LocalAuthentication
import MapKit

extension ContentView {
    @Observable
    class ViewModel {
        private(set) var locations: [Location]
        var selectedPlace: Location?
        var isunlocked = true //Cambiar a false al terminar modificaciones
        var is2D = false //Challenge 1
        var isError = false //Challenge 2
        
        let savePath = URL.documentsDirectory.appending(path: "SavedPlaces")
        
        init(){
            do{
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            }catch{
                locations = []
            }
        }
        
        func save() {
            do{
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            }catch{
                print("Unable to save data")
            }
        }
        func addLocation(at point: CLLocationCoordinate2D){
            let newLocation = Location(id: UUID(), name: "New Location", description: "", latitude: point.latitude, longitude: point.longitude)
            locations.append(newLocation)
        }
        func updateLocation(location: Location){
            guard let selectedPlace else {return}
            
            if let index = locations.firstIndex(of: selectedPlace){
                locations[index] = location
                save()
            }
        }
        func authenticate() {
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Please authenticate yourself to unlock your places."
                
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason){succes, authenticationError in
                    if succes {
                        self.isunlocked = true
                        self.isError = false
                    }else{
                        self.isError = true //Challenge 2
                    }
                }
            } else {
                // No biometrics
            }
        }
    }
}
