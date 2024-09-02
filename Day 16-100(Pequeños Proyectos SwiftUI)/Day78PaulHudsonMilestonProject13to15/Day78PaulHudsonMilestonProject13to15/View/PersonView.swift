//
//  PersonView.swift
//  Day78PaulHudsonMilestonProject13to15
//
//  Created by Manuel Bermudo on 21/8/24.
//

import MapKit
import SwiftUI

struct PersonView: View {
    
    let person: Person
    
    var body: some View {
        ScrollView{
            VStack{
                Text(person.name)
                    .font(.title)
                    .bold()
                Text(person.surname)
                    .font(.title)
                    .bold()
                
                if let imageData = person.imageData, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .padding()
                } else {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .padding()
                }
                Text(person.role)
                    .font(.title2)
                Text("Location")
                    .font(.title2)
                    .bold()
                    .padding(.top)
                Map(){
                    Annotation("", coordinate: CLLocationCoordinate2D(latitude: person.latitude, longitude: person.longitude)){
                        Image(systemName: "mappin.and.ellipse")
                                .resizable()
                                .frame(width: 44, height: 44)
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.horizontal)
                .onTapGesture {openInMaps()}
                
            }
            Spacer()
        }
    }
    func openInMaps() {
        let latitude = person.latitude
        let longitude = person.longitude
        let url = URL(string: "http://maps.apple.com/?ll=\(latitude),\(longitude)")!
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

#Preview {
    PersonView(person: Person(name: "Nombre", surname: "Apellido", role: "Rol", imageData: Data(), latitude: 0.0, longitude: 0.0))
}

