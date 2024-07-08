//
//  AddView.swift
//  Day59PaulHudsonSwiftDataProject
//
//  Created by Manuel Bermudo on 7/7/24.
//

import SwiftUI
import SwiftData

struct AddView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    
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
                    
                    //try? modelContext.delete(model: Expenses.self)
                    
                    let item = Expenses(name: name, type: type, amount: amount)
                    modelContext.insert(item)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddView()
}
