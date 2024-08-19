//
//  AddView.swift
//  Day76PaulHudsonAccessibilitySandbox
//
//  Created by Manuel Bermudo on 15/8/24.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    var personalExpenses: Expenses
    var bussinesExpenses: Expenses
    
    let types = ["Bussines", "Personal"]
    
    var body: some View {
        NavigationStack{
            Form{
                TextField("Name", text: $name)
                Picker("Type", selection: $type){
                    ForEach(types, id: \.self){
                        Text($0)
                    }
                }
                TextField("Amount", value: $amount, format: .currency(code: "EUR"))
            }
            .navigationTitle("Add new expense")
            .toolbar{
                Button("Save"){
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    if type == "Personal"{
                        personalExpenses.items.append(item)
                    }else{
                        bussinesExpenses.items.append(item)
                    }
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddView(personalExpenses: Expenses(), bussinesExpenses: Expenses())
}
