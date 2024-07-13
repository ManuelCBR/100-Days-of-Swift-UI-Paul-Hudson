//
//  ContentView.swift
//  Day63PaulHudsonInstafilter
//
//  Created by Manuel Bermudo on 13/7/24.
//
import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {
    
    @State private var image: Image?
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
        }
        .onAppear(perform: loadImage)
        ContentUnavailableView{
            Label("No snippets", systemImage: "swift")
        } description: {
            Text("You don't have any saved snippets yet")
        } actions: {
            Button("Create snippet"){
                
            }
            .buttonStyle(.borderedProminent)
        }
    }
    func loadImage(){
        let imputImage = UIImage(resource: .example)
        let beginImage = CIImage(image: imputImage)
        
        let context = CIContext()
        let currentFilter = CIFilter.pixellate()
        
        currentFilter.inputImage = beginImage
        let amount = 1.0
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(amount, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(amount * 200, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(amount * 30, forKey: kCIInputScaleKey) }
        
        guard let outputImage = currentFilter.outputImage else {return}
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else {return}
        
        let uiImage = UIImage(cgImage: cgImage)
        image = Image(uiImage: uiImage)
    }
}

#Preview {
    ContentView()
}
