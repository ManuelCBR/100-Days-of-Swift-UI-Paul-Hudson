//
//  ContentView.swift
//  Day73PaulHudsonBucketList
//
//  Created by Manuel Bermudo on 3/8/24.
//

import MapKit
import SwiftUI

/**
 Challenge
 One of the best ways to learn is to write your own code as often as possible, so here are three ways you should try extending this app to make sure you fully understand what’s going on.
 - 1. Allow the user to switch map modes, between the standard mode and hybrid.
 - 2. Our app silently fails when errors occur during biometric authentication, so add code to show those errors in an alert.
 - 3. Create another view model, this time for EditView. What you put in the view model is down to you, but I would recommend leaving dismiss and onSave in the view itself – the former uses the environment, which can only be read by the view, and the latter doesn’t really add anything when moved into the model.
 */

struct ContentView: View {
    
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.3886, longitude: -5.9823),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )
    
    @State private var viewModel = ViewModel()

    var body: some View {
        
        ZStack{
            if viewModel.isunlocked {
                MapReader{proxy in
                    Map(initialPosition: startPosition){
                        ForEach(viewModel.locations) { location in
                            Annotation(location.name, coordinate: location.coordinate){
                                Image(systemName: "star.circle")
                                    .resizable()
                                    .foregroundStyle(.red)
                                    .frame(width: 44, height: 44)
                                    .background(.white)
                                    .clipShape(.circle)
                                    .onLongPressGesture {
                                        viewModel.selectedPlace = location
                                    }
                            }
                        }
                    }
                    .onTapGesture {position in
                        if let coordinate = proxy.convert(position, from: .local){
                            viewModel.addLocation(at: coordinate)
                        }
                    }
                    .mapStyle(viewModel.is2D ? .standard : .imagery) //Challenge 1
                    .sheet(item: $viewModel.selectedPlace){ place in
                        EditView(location: place){
                            viewModel.updateLocation(location: $0)
                        }
                    }
                }
                //Challenge 1
                VStack{
                    Button(action: {
                        viewModel.is2D = false
                    }, label: {
                        Image(systemName: "map.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundStyle(.black)
                    })
                    .padding(.top, 6)
                    Rectangle()
                        .frame(width: 40, height: 1)
                    Button("2D"){viewModel.is2D = true}
                        .font(.title2)
                        .bold()
                        .foregroundStyle(.black)
                        .padding(.bottom, 9)
                        
                }
                .background(.gray .opacity(0.8))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 1)
                )
                .position(x: UIScreen.main.bounds.width - 40, y: UIScreen.main.bounds.height - 140)
            } else {
                Button ("Unlock Places", action: viewModel.authenticate)
                    .padding()
                    .background(.blue)
                    .foregroundColor(.white)
                    .clipShape(.capsule)
                    //Challenge 2
                    .alert("Error Authentication", isPresented: $viewModel.isError) {
                                Button("OK", role: .cancel) { }
                    }
            }
        }
    }
}

#Preview {
    ContentView()
}
