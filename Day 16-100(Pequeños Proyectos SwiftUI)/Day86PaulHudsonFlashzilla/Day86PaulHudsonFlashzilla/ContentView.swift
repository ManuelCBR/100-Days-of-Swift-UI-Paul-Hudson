//
//  ContentView.swift
//  Day86PaulHudsonFlashzilla
//
//  Created by Manuel Bermudo on 6/9/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var currentAmountScaleEfect = 0.0
    @State private var finalAmountScaleEfect = 1.0
    @State private var currentAmountRotationEfect = Angle.zero
    @State private var finalAmountRotationEfect = Angle.zero
    
    // How far the circle has been dragged
    @State private var offset = CGSize.zero
    // Whether it is currently being dragged or not
    @State private var isDragging = false
    
    var body: some View {
        VStack {
            Text("Scale effect")
                .scaleEffect(finalAmountScaleEfect + currentAmountScaleEfect)
                .gesture(
                    MagnifyGesture()
                        .onChanged { value in
                            currentAmountScaleEfect = value.magnification - 1
                        }
                        .onEnded { value in
                            finalAmountScaleEfect += currentAmountScaleEfect
                            currentAmountScaleEfect = 0
                        }
                )
                .padding()
            Text("Rotation effect")
                .rotationEffect(finalAmountRotationEfect + currentAmountRotationEfect)
                .gesture(
                    RotateGesture()
                        .onChanged { value in
                            currentAmountRotationEfect = value.rotation
                        }
                        .onEnded { value in
                            finalAmountRotationEfect += currentAmountRotationEfect
                            currentAmountRotationEfect = .zero
                        }
                )
            
            // A drag gesture that updates offset and isDragging as it moves around
            let dragGesture = DragGesture()
                .onChanged { value in offset = value.translation }
                .onEnded { _ in
                    withAnimation {
                        offset = .zero
                        isDragging = false
                    }
                }

            // A long press gesture that enables isDragging
            let pressGesture = LongPressGesture()
                .onEnded { value in
                    withAnimation {
                        isDragging = true
                    }
                }

            // A combined gesture that forces the user to long press then drag
            let combined = pressGesture.sequenced(before: dragGesture)

            // A 64x64 circle that scales up when it's dragged, sets its offset to whatever we had back from the drag gesture, and uses our combined gesture
            Circle()
                .fill(.red)
                .frame(width: 64, height: 64)
                .scaleEffect(isDragging ? 1.5 : 1)
                .offset(offset)
                .gesture(combined)
            
            VStack {
                Text("Vstack tapped")
                    .padding()
                Spacer().frame(height: 100)
                Text("Also between")
                    .padding()
            }
            .contentShape(.rect)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.secondary)
            )
            .onTapGesture {
                print("Vstack tapped")
            }
            VStack {
                Text("Vstack tapped")
                    .padding()
                Spacer().frame(height: 100)
                Text("Only on text")
                    .padding()
            }
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.secondary)
            )
            .onTapGesture {
                print("Vstack tapped")
            }
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
