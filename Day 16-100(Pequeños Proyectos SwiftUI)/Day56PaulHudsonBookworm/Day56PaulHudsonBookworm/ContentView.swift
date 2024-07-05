//
//  ContentView.swift
//  Day56PaulHudsonBookworm
//
//  Created by Manuel Bermudo on 3/7/24.
//

import SwiftData
import SwiftUI

/**
Challenge
- 1. Right now it’s possible to select no title, author, or genre for books, which causes a problem for     the detail view. Please fix this, either by forcing defaults, validating the form, or showing a default       picture for unknown genres – you can choose.
- 2. Modify ContentView so that books rated as 1 star are highlighted somehow, such as having           their name shown in red.
- 3. Add a new “date” attribute to the Book class, assigning Date.now to it so it gets the current            date and time, then format that nicely somewhere in DetailView.
 */

struct ContentView: View {
    
    @Environment (\.modelContext) var modelContext
    @Query(sort: [
        SortDescriptor(\Book.title),
        SortDescriptor(\Book.author)
    ]) var books: [Book]
    
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationStack {
            List{
                ForEach(books){book in
                    NavigationLink(value:book){
                        HStack{
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            VStack(alignment: .leading){
                                Text(book.title)
                                    .font(.headline)
                                    //Challenge 2
                                    .foregroundStyle(book.rating == 1 ? .red : .white)
                                Text(book.author)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
            .navigationTitle("Bookworm")
            .navigationDestination(for: Book.self){ book in
                    DetailView(book: book)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing){
                    Button("Add Book", systemImage: "plus"){
                        showingAddScreen.toggle()
                    }
                }
                ToolbarItem(placement: .topBarLeading){
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAddScreen) {
                AddBookView()
            }
        }
    }
    func deleteBooks (at offsets: IndexSet){
        for offset in offsets {
            let book = books[offset]
            modelContext.delete(book)
        }
    }
}

#Preview {
    ContentView()
}
