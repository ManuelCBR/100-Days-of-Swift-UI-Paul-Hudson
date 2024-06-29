//
//  ContentView.swift
//  Day49PaulHudsonCupcakeCorner
//
//  Created by Manuel Bermudo on 29/6/24.
//

import SwiftUI

struct Response: Codable{
    var results: [Result]
}
struct Result: Codable{
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct ContentView: View {
    
    @State private var results = [Result]()
    @State private var userName = ""
    @State private var email = ""
    
    var disableForm: Bool {
        userName.count < 5 || email.count < 5
    }
    
    var body: some View {
        NavigationStack{
            Text("Creating a list from a url")
            //Creating a list from a url
            List(results, id: \.trackId){item in
                Text(item.trackName)
                    .font(.headline)
                Text(item.collectionName)
            }
            .task {
                await loadData()
            }
            VStack{
                Rectangle()
                    .frame(height: 2)
                Text("Resizing an image from a url")
                    .font(.subheadline.italic())
                //Resizing an image from a url
                AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")){phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFit()
                    } else if phase.error != nil {
                        Text("There was an error loading the image")
                    } else {
                        ProgressView()
                    }
                }
                .frame(width: 100, height: 100)
                Rectangle()
                    .frame(height: 2)
                //Validating an disabling forms
                Form{
                    Section("Validating an disabling forms"){
                        TextField("Username", text: $userName)
                        TextField("Email", text: $email)
                    }
                    Section{
                        Button("Create account"){
                            print("Creating account")
                        }
                    }
                    .disabled(disableForm)
                }
            }
        }
    }
    func loadData() async{
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song")else{
            print("Invalid URL")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodeResponse = try? JSONDecoder().decode(Response.self, from: data){
                results = decodeResponse.results
            }
        }catch{
            print("Invalid data")
        }
    }
}

#Preview {
    ContentView()
}
