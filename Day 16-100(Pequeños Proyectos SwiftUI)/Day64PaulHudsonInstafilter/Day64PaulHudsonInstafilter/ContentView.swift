//
//  ContentView.swift
//  Day64PaulHudsonInstafilter
//
//  Created by Manuel Bermudo on 14/7/24.
//

import StoreKit
import PhotosUI
import SwiftUI

struct ContentView: View {
    
    @Environment (\.requestReview) var requestReview
    
    @State private var pickerItems = [PhotosPickerItem]()
    @State private var selectedImages = [Image]()
    
    var body: some View {
        VStack {
            let example = Image(.example)
            Button("Leave a review"){
                requestReview()
            }
            Divider()
            ShareLink(item: example, preview: SharePreview("Cueva del Gato", image: example)){
                Label("Share Cueva del Gato", systemImage: "tree.circle")
            }
            Divider()
            PhotosPicker(selection: $pickerItems, maxSelectionCount: 3 , matching: .images){
                Label("Select a picture", systemImage: "photo")
            }
            ScrollView{
                ForEach (0..<selectedImages.count, id:\.self){i in
                    selectedImages[i]
                        .resizable()
                        .scaledToFit()
                }
            }
        }
        .onChange(of: pickerItems){
            Task{
                selectedImages.removeAll()
                
                for item in pickerItems {
                    if let loadedImage = try await item.loadTransferable(type: Image.self){
                        selectedImages.append(loadedImage)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
