//
//  AddBookView.swift
//  Day56PaulHudsonBookworm
//
//  Created by Manuel Bermudo on 3/7/24.
//

import SwiftUI

//Challenge 1
extension String {
    var isValidField: Bool {
        let trimmedString = self.trimmingCharacters(in: .whitespacesAndNewlines)
        return !trimmedString.isEmpty
    }
}

struct AddBookView: View {
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var genre = "Fantasy"
    @State private var review = ""
    @State private var rating = 3
    @State private var currentDate = Date() //Challenge 3
    
    //Challenge 1
    var hasValidBook: Bool{
        if title.isEmpty || author.isEmpty || review.isEmpty {
            return false
        }
        if !title.isValidField || !author.isValidField || !review.isValidField {
            return false
        }
        return true
    }
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre){
                        ForEach(genres, id:\.self){
                            Text($0)
                        }
                    }
                }
                Section("Write a review"){
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                }
                Section{
                    Button("Save"){
                        let newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating, date: Date()) //Challenge 3 (date)
                        modelContext.insert(newBook)
                        dismiss()
                    }
                    //Challenge 2
                    .disabled(hasValidBook == false)
                }
            }
            .navigationTitle("Add Book")
        }
    }
}

#Preview {
    AddBookView()
}
