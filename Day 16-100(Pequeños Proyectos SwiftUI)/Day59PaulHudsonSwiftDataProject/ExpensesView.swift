//
//  ExpensesView.swift
//  Day59PaulHudsonSwiftDataProject
//
//  Created by Manuel Bermudo on 8/7/24.
//

import SwiftData
import SwiftUI
//Challenge 3
struct ExpensesView: View {
    
    @Query var expense: [Expenses]
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        List{
            Section {
                ForEach(expense){item in
                    HStack{
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                                .font(.subheadline)
                        }
                        Spacer()
                        Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    }
                    .listRowBackground(backgroundListColor(for: item.amount))
                }
                .onDelete(perform: removeItems)
            }
        }
    }
    func removeItems (at offsets: IndexSet){
        for offset in offsets {
            let expense = expense[offset]
            modelContext.delete(expense)
        }
        
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
    //Challenge 3
    init(expenseType: String){
        _expense = Query(filter: #Predicate<Expenses> {expenses in
            expenses.type == expenseType
        }, sort: \Expenses.name)
    }
}

#Preview {
    ExpensesView(expenseType: "Default")
        .modelContainer(for: Expenses.self)
}
