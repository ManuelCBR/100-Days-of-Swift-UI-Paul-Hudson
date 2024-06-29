//
//  ContentView.swift
//  Day38PaulHudsoniExpense
//
//  Created by Manuel Bermudo on 19/6/24.
//

import SwiftUI

/**
 Challenge
 One of the best ways to learn is to write your own code as often as possible, so here are three ways you should try extending this app to make sure you fully understand what’s going on.

 - Use the user’s preferred currency, rather than always using US dollars.
 - Modify the expense amounts in ContentView to contain some styling depending on their value – expenses under $10 should have one style, expenses under $100 another, and expenses over $100 a third style. What those styles are depend on you.
 - For a bigger challenge, try splitting the expenses list into two sections: one for personal expenses, and one for business expenses. This is tricky for a few reasons, not least because it means being careful about how items are deleted!
 */

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var items = [ExpenseItem](){
        didSet {
            if let encoded = try? JSONEncoder().encode(items){
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    init(){
        if let savedItems = UserDefaults.standard.data(forKey: "Items"){
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems){
                items = decodedItems
                return
            }
        }
        items = []
    }
}

struct ContentView: View {
    
    @State private var personalExpenses = Expenses()
    @State private var bussinesExpenses = Expenses()
    @State private var showingAddExpense = false

    var body: some View {
        NavigationStack {
            List{
                //Challenge 3
                Section("Personal"){
                    ForEach(personalExpenses.items){item in
                        HStack{
                            Text(item.name)
                                .font(.headline)
                            Spacer()
                            //Challenge 1
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        }
                        //Challenge 2
                        .listRowBackground(backgroundListColor(for: item.amount))
                    }
                    .onDelete(perform: removePersonalItems)
                }
                Section("Bussines"){
                    ForEach(bussinesExpenses.items){item in
                        HStack{
                            Text(item.name)
                                .font(.headline)
                            Spacer()
                            //Challenge 1
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        }
                        //Challenge 2
                        .listRowBackground(backgroundListColor(for: item.amount))
                    }
                    .onDelete(perform: removeBussinesItems)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus"){
                    showingAddExpense = true
                }
            }
            .sheet(isPresented: $showingAddExpense){
                AddView(personalExpenses: personalExpenses, bussinesExpenses: bussinesExpenses)
            }
        }
    }
    func removePersonalItems (at offsets: IndexSet){
        personalExpenses.items.remove(atOffsets: offsets)
        
    }
    func removeBussinesItems (at offsets: IndexSet){
        //Challenge 3
        bussinesExpenses.items.remove(atOffsets: offsets)
    }
    //Challenge 2
    func backgroundListColor (for amount: Double) -> Color{
        switch amount{
            case ...10:
                return Color.green
            case 10..<100:
                return Color.yellow
            case 100...:
                return Color.red
            default:
                return Color.gray
        }
    }
}

#Preview {
    ContentView()
}
    