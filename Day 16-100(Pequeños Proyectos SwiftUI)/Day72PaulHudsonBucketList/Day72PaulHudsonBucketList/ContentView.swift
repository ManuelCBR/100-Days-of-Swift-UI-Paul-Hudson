//
//  ContentView.swift
//  Day72PaulHudsonBucketList
//
//  Created by Manuel Bermudo on 2/8/24.
//

import MapKit
import SwiftUI

struct ContentView: View {
    
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.3886, longitude: -5.9823),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )
    
    @State private var viewModel = ViewModel()

    var body: some View {
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
                .sheet(item: $viewModel.selectedPlace){ place in
                    EditView(location: place){
                        viewModel.updateLocation(location: $0)
                    }
                }
            }
        } else {
            Button ("Unlock Places", action: viewModel.authenticate)
                .padding()
                .background(.blue)
                .foregroundColor(.white)
                .clipShape(.capsule)
        }
    }
}

#Preview {
    ContentView()
}
