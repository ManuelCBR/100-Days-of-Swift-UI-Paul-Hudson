//
//  EditView.swift
//  Day73PaulHudsonBucketList
//
//  Created by Manuel Bermudo on 6/8/24.
//

import SwiftUI

struct EditView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var viewModel: EditViewViewModel //Challenge 3
    
    var body: some View {

        NavigationStack{
            Form {
                Section {
                    TextField ("Place name", text: $viewModel.name)
                    TextField ("Description", text: $viewModel.description)
                }
                Section("Nearby..."){
                    switch viewModel.loadingState {
                        case .loading:
                            Text ("Loading...")
                        case .loaded:
                            ForEach(viewModel.pages, id: \.pageid) { page in
                                Text(page.title)
                                    .font(.headline)
                                + Text(": ") +
                                Text(page.description)
                                    .italic()
                            }
                        case .failed:
                            Text("Please try again later")
                    }
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                Button("Save"){
                    viewModel.save()
                    dismiss()
                }
            }
            .task {
                await viewModel.fetchNearbyPlaces()
            }
        }
    }
    init(location: Location, onSave: @escaping (Location) -> Void) {
        _viewModel = State(wrappedValue: EditViewViewModel(location: location, onSave: onSave))
    }
    
}

#Preview {
    EditView(location: .example) { _ in }
}
