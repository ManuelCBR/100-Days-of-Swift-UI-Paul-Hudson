//
//  ContentView.swift
//  Day67PaulHudsonInstafilter
//
//  Created by Manuel Bermudo on 16/7/24.
//

//
//  ContentView.swift
//  Day66PaulHudsonInstafilter
//
//  Created by Manuel Bermudo on 16/7/24.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import PhotosUI
import StoreKit
import SwiftUI

/**
 Challenge
 One of the best ways to learn is to write your own code as often as possible, so here are three ways you should try extending this app to make sure you fully understand what’s going on.

 - 1. Try making the Slider and Change Filter buttons disabled if there is no image selected.
 - 2. Experiment with having more than one slider, to control each of the input keys you care about. For example, you might have one for radius and one for intensity.
 - 3. Explore the range of available Core Image filters, and add any three of your choosing to the app.
 */

struct ContentView: View {
    
    @State private var processedImage: Image?
    @State private var filterIntensity = 0.0
    @State private var filterRadius = 0.0
    @State private var selectedItem: PhotosPickerItem?
    @State private var showingFilters = false
    @State private var buttonSliderUnavailable = false //Challenge 3
    
    
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    //Challenge 1
    var imageSelected: Bool {
        if selectedItem == nil {
            return true
        } else {return false}
    }
    
    @AppStorage("filterCount") var filterCount = 0
    @Environment (\.requestReview) var requestReview
    
    var body: some View {
        NavigationStack{
            VStack {
                Spacer()
                
                PhotosPicker(selection: $selectedItem){
                    if let processedImage {
                        processedImage
                            .resizable()
                            .scaledToFit()
                    } else {
                        ContentUnavailableView("No picture", systemImage: "photo.badge.plus", description: Text("Tap  to import a photo"))
                    }
                }
                .buttonStyle(.plain)
                .onChange(of: selectedItem, loadImage)
                
                Spacer()
                
                VStack{
                    HStack{
                        Text("Intensity")
                        Slider(value: $filterIntensity)
                            .onChange(of: filterIntensity, applyProcessing)
                        //Challenge 1 and part of the challenge 3
                            .disabled(imageSelected || buttonSliderUnavailable)
                    }
                    //Challenge 2
                    HStack{
                        Text("Radius   ")
                        Slider(value: $filterRadius)
                            .onChange(of: filterRadius, applyProcessing)
                        //Challenge 1 and part of the challenge 3
                            .disabled(imageSelected || buttonSliderUnavailable)
                    }
                }
                
                HStack(alignment: .center){
                    Button("Change Filter"){
                        changeFilter()
                        buttonSliderUnavailable = false //Challenge 3
                    }
                    .disabled(imageSelected) //Challenge 1
                    Spacer()
                    if let processedImage {
                        ShareLink(item: processedImage, preview: SharePreview ("Instafilter image", image: processedImage))
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
            .confirmationDialog("Select a filter", isPresented: $showingFilters){
                Button("Crystallize"){
                    setFilter(CIFilter.crystallize())
                }
                Button("Edges"){setFilter(CIFilter.edges())}
                Button("Gaussian Blur"){setFilter(CIFilter.gaussianBlur())}
                Button("Pixellate"){setFilter(CIFilter.pixellate())}
                Button("Sepia Tone"){setFilter(CIFilter.sepiaTone())}
                Button("Unsharp Mask"){setFilter(CIFilter.unsharpMask())}
                Button("Vignette"){setFilter(CIFilter.vignette())}
                //Challenge 3
                Button("Comic Effect"){
                    setFilter(CIFilter.comicEffect())
                    buttonSliderUnavailable = true
                }
                Button("Color Invert"){
                    setFilter(CIFilter.colorInvert())
                    buttonSliderUnavailable = true
                }
                Button("Photo Effect Process"){
                    setFilter(CIFilter.photoEffectProcess())
                    buttonSliderUnavailable = true
                }
                Button("Cancel", role: .cancel){}
            }
        }
    }
    func changeFilter() {
        showingFilters = true
    }
    func loadImage() {
        Task{
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else {return}
            guard let inputImage = UIImage(data: imageData) else {return}
            
            let beginImage = CIImage(image: inputImage)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            applyProcessing()
        }
    }
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
        //Challenge 2
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterRadius * 200, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey) }
        
        guard let outputImage = currentFilter.outputImage else {return}
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else {return}
        
        let uiImage = UIImage(cgImage: cgImage)
        processedImage = Image(uiImage: uiImage)
    }
    @MainActor func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
        filterCount += 1
        
        if filterCount >= 5 {
            requestReview()
        }
    }
}

#Preview {
    ContentView()
}
