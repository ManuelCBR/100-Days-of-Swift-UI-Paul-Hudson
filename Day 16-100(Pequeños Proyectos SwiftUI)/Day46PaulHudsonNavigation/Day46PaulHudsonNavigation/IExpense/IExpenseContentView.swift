//
//  IExpenseContentView.swift
//  Day46PaulHudsonNavigation
//
//  Created by Manuel Bermudo on 24/6/24.
//

import SwiftUI

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

struct IExpenseContentView: View {
    @State private var personalExpenses = Expenses()
    @State private var bussinesExpenses = Expenses()
    @State private var showingAddExpense = false

    var body: some View {
        NavigationStack {
            List{
                Section("Personal"){
                    ForEach(personalExpenses.items){item in
                        HStack{
                            Text(item.name)
                                .font(.headline)
                            Spacer()
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        }
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
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        }
                        .listRowBackground(backgroundListColor(for: item.amount))
                    }
                    .onDelete(perform: removeBussinesItems)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                //Challenge1
                NavigationLink{
                    AddViewIExpense(personalExpenses: personalExpenses, bussinesExpenses: bussinesExpenses)
                }label:{
                    Button("Add Expense", systemImage: "plus"){
                        showingAddExpense = true
                    }
                }
                
            }
           
            /*.sheet(isPresented: $showingAddExpense){
                AddViewIExpense(personalExpenses: personalExpenses, bussinesExpenses: bussinesExpenses)
            }*/
        }
    }
    func removePersonalItems (at offsets: IndexSet){
        personalExpenses.items.remove(atOffsets: offsets)
        
    }
    func removeBussinesItems (at offsets: IndexSet){
        bussinesExpenses.items.remove(atOffsets: offsets)
    }
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
    IExpenseContentView()
}
