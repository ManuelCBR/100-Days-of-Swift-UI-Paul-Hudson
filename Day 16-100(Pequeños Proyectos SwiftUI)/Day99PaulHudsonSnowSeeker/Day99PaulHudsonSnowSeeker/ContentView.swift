//
//  ContentView.swift
//  Day99PaulHudsonSnowSeeker
//
//  Created by Manuel Bermudo on 11/3/25.
//

import SwiftUI

/**
 Challenge
 One of the best ways to learn is to write your own code as often as possible, so here are three ways you should try extending this app to make sure you fully understand what’s going on.
 1. Add a photo credit over the ResortView image. The data is already loaded from the JSON for this purpose, so you just need to make it look good in the UI.
 2. Fill in the loading and saving methods for Favorites.
 3. For a real challenge, let the user sort the resorts in ContentView either using the default order, alphabetical order, or country order.
 */

//Challenge 3
enum SortType {
    case defaultOrder, alphabeticalOrder, countryOrder
}

struct ContentView: View {
    
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    @State private var favorites = Favorites()
    @State private var searchText = ""
    @State private var sortOrder: SortType = .defaultOrder //Challenge 3
    
    var filteredResorts: [Resort] {
            var result = resorts

            // searched filter
            if !searchText.isEmpty {
                result = result.filter { $0.name.localizedStandardContains(searchText) }
            }

            // Order by user (Challenge 3)
            switch sortOrder {
            case .defaultOrder:
                break // Keep original order
            case .alphabeticalOrder:
                result.sort { $0.name < $1.name }
            case .countryOrder:
                result.sort { $0.country < $1.country }
            }

            return result
        }
    
    var body: some View {
        NavigationSplitView {
            List (filteredResorts) { resort in
                NavigationLink(value: resort) {
                    HStack{
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(.rect(cornerRadius: 5))
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            )
                        
                        VStack(alignment: .leading){
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundStyle(.secondary)
                        }
                        
                        if favorites.contains(resort) {
                            Spacer()
                            
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favorite resort")
                                .foregroundStyle(.red)
                                
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .navigationDestination(for: Resort.self) { resort in
                ResortView(resort: resort)
            }
            .searchable(text: $searchText, prompt: "Search for a resort")
            //Challenge 3
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Picker("Sort", selection: $sortOrder) {
                        Label("Default", systemImage: "list.bullet").tag(SortType.defaultOrder)
                        Label("Alphabetical", systemImage: "textformat").tag(SortType.alphabeticalOrder)
                        Label("Country", systemImage: "globe").tag(SortType.countryOrder)
                    }
                    .pickerStyle(.menu)
                }
            }
        } detail: {
            WelcomeView()
        }
        .environment(favorites)
    }
}

#Preview {
    ContentView()
}
