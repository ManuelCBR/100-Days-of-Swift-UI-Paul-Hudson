//
//  ContentView.swift
//  Day39PaulHudsonMoonshot
//
//  Created by Manuel Bermudo on 20/6/24.
//

import SwiftUI
struct User: Codable{
    let name: String
    let adress: Adress
}
struct Adress: Codable{
    let street: String
    let city: String
}

struct ContentView: View {
    let layout = [
        GridItem(.adaptive(minimum: 80, maximum: 120))
    ]
    
    var body: some View {
        NavigationStack{
            NavigationLink("Decode JSON to know Taylor Swift's adress"){
                    let input = """
                        {
                        "name": "Taylor Swift",
                        "adress": {
                            "street": "555, Taylor Swift Avenue",
                            "city": "Nashville"
                        }
                        }
                        """
                    let data = Data(input.utf8)
                    let decoder = JSONDecoder()
                    if let user = try? decoder.decode(User.self, from: data){
                        Text(user.adress.street)
                    }
                
            }
            ScrollView{
                LazyVGrid(columns: layout){
                    ForEach(0..<1000){
                        Text("Item \($0)")
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
