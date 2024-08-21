//
//  PersonView.swift
//  Day77PaulHudsonMilestonProject13to15
//
//  Created by Manuel Bermudo on 21/8/24.
//

import SwiftUI

struct PersonView: View {
    
    let person: Person
    
    var body: some View {
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
        }
        Spacer()
    }
}

#Preview {
    PersonView(person: Person(name: "Nombre", surname: "Apellido", role: "Rol", imageData: Data()))
}
