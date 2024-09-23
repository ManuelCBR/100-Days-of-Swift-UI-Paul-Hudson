//
//  ContentView.swift
//  Day91PaulHudsonFlashzilla
//
//  Created by Manuel Bermudo on 11/9/24.
//

/**
 Challenge
 One of the best ways to learn is to write your own code as often as possible, so here are some ways you should try extending this app to make sure you fully understand what’s going on.

 - 1. When adding a card, the text fields keep their current text. Fix that so that the textfields clear themselves after a card is added.
 - 2. If you drag a card to the right but not far enough to remove it, then release, you see it turn red as it slides back to the center. Why does this happen and how can you fix it? (Tip: think about the way we set offset back to 0 immediately, even though the card hasn’t animated yet. You might solve this with a ternary within a ternary, but a custom modifier will be cleaner.)
- 3. For a harder challenge: when the users gets an answer wrong, add that card back into the array so the user can try it again. Doing this successfully means rethinking the ForEach loop, because relying on simple integers isn’t enough – your cards need to be uniquely identifiable.
 
 Still thirsty for more? Try upgrading our loading and saving code in two ways:
 
- 1. Make it use an alternative approach to saving data, e.g. documents JSON rather than UserDefaults, or SwiftData – this is generally a good idea, so you should get practice with this.
- 2. Try to find a way to centralize the loading and saving code for the cards. You might need to experiment a little to find something you like!
 */

import SwiftData
import SwiftUI

extension View {
    func stacked (at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(y: offset * 10)
    }
}

struct ContentView: View {
    
    @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.accessibilityVoiceOverEnabled) var accessibilityVoiceOverEnabled
    @Environment(\.modelContext) var modelContext // Last part of challenge

    @Query private var cards: [Card] // Last part of challenge
    @State private var timeRemaining = 100
    @State private var isActive = true
    @State private var showingEditScreen = false
    @State private var visibleCards: [Card] = []
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack{
            Image(decorative: "background")
                .resizable()
                .ignoresSafeArea()
            VStack{
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(.black.opacity(0.75))
                    .clipShape(.capsule)
                ZStack{
                    ForEach(visibleCards.indices, id: \.self) { index in
                        CardView(card: visibleCards[index]) {
                                withAnimation {
                                    removeCard(at: index)
                                }
                            }
                        .stacked(at: index, in: visibleCards.count)
                        .allowsHitTesting(index == visibleCards.count - 1)
                        .accessibilityHidden(index < visibleCards.count - 1)
                        }
                    
                }
                .allowsHitTesting(timeRemaining > 0)
                
                if visibleCards.isEmpty {
                    Button("Start Again", action: resetCards)
                        .padding()
                        .background(.white)
                        .foregroundStyle(.black)
                        .clipShape(.capsule)
                }
            }
            
            VStack{
                HStack{
                    Spacer()
                    Button {
                        showingEditScreen = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(.circle)
                    }
                }
                Spacer()
            }
            .foregroundStyle(.white)
            .font(.largeTitle)
            .padding()
            
            if accessibilityDifferentiateWithoutColor || accessibilityVoiceOverEnabled {
                VStack {
                    Spacer()
                    
                    HStack {
                        Button {
                            withAnimation{
                                removeCard(at: cards.count - 1)
                            }
                        } label: {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(.circle)
                        }
                        .accessibilityLabel("Wrong")
                        .accessibilityHint("Mark your answer as being incorrect.")
                        
                        Spacer()
                        Button {
                            withAnimation{
                                removeCard(at: cards.count - 1)
                            }
                        } label: {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(.circle)
                        }
                        .accessibilityLabel("Correct")
                        .accessibilityHint("Mark your answer as being correct.")
                    }
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
        }
        .onReceive(timer) { time in
            guard isActive else {return}
            
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
        .onChange(of: scenePhase) {
            if scenePhase == .active {
                if cards.isEmpty == false {
                    isActive = true
                }
            } else {
                isActive = false
            }
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: resetCards, content: EditCardsView.init)
        .onAppear{
            resetCards()
        }
    }
    func removeCard(at index: Int) {
        guard index >= 0 else {return}
        visibleCards.remove(at: index)
        
        if visibleCards.isEmpty {
            isActive = false
        }
    }
    
    func resetCards() {
        timeRemaining = 100
        isActive = true
        visibleCards = cards
    }
}

#Preview {
    ContentView()
}
