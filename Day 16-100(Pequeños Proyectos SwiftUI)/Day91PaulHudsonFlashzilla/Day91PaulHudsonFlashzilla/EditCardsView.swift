//
//  EditCardsView.swift
//  Day91PaulHudsonFlashzilla
//
//  Created by Manuel Bermudo on 11/9/24.
//

import SwiftData
import SwiftUI

struct EditCardsView: View {
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var cards = [Card]()
    @Query private var cards2: [Card]
    @State private var newPrompt = ""
    @State private var newAnswer = ""
    
    var body: some View {
        NavigationStack {
            List {
                Section("Add new card") {
                    TextField("Prompt", text: $newPrompt)
                    TextField("Answer", text: $newAnswer)
                    Button("Add Card") {
                        addCard()
                        //Challenge 1
                        newPrompt = ""
                        newAnswer = ""
                    }
                }

                Section {
                    ForEach(cards2) { card in
                        VStack(alignment: .leading) {
                            Text(card.prompt)
                                .font(.headline)
                            Text(card.answer)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .onDelete(perform: removeCards)
                }
            }
            .navigationTitle("Edit Cards")
            .toolbar {
                Button("Done", action: done)
            }
        }
    }
    func done() {
        dismiss()
    }
    func addCard() {
        let trimmedPrompt = newPrompt.trimmingCharacters(in: .whitespaces)
        let trimmedAnswer = newAnswer.trimmingCharacters(in: .whitespaces)
        guard trimmedPrompt.isEmpty == false && trimmedAnswer.isEmpty == false else { return }

        // Last part of challenge
        let card = Card(id: UUID(), prompt: trimmedPrompt, answer: trimmedAnswer)
        modelContext.insert(card)
        do {
            try modelContext.save()
        } catch {
            print("Error al guardar el contexto: \(error.localizedDescription)")
        }
    }

    func removeCards(at offsets: IndexSet) {
        // Last part of challenge
        for index in offsets {
            let card = cards2[index]
            modelContext.delete(card)
            do {
                try modelContext.save()
            } catch {
                print("Error to save the context: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    EditCardsView()
}
