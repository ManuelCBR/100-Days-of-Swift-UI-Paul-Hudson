//
//  AddViewIExpense.swift
//  Day46PaulHudsonNavigation
//
//  Created by Manuel Bermudo on 24/6/24.
//

import SwiftUI

struct AddViewIExpense: View {
    @Environment(\.dismiss) var dismiss
    //Challenge 1
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name = "Add new expense"
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    //var expenses
    var personalExpenses: Expenses
    var bussinesExpenses: Expenses
    
    let types = ["Bussines", "Personal"]
    
    var body: some View {
        NavigationStack{
            Form{
                //TextField("Name", text: $name)
                Picker("Type", selection: $type){
                    ForEach(types, id: \.self){
                        Text($0)
                    }
                }
                TextField("Amount", value: $amount, format: .currency(code: "EUR"))
            }
            .navigationTitle($name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                //Challenge 1
                ToolbarItem(placement: .topBarLeading){
                    Button("Cancel"){
                        presentationMode.wrappedValue.dismiss()
                    }
                    
                }
                ToolbarItem(placement: .topBarTrailing){
                    Button("Save"){
                        let item = ExpenseItem(name: name, type: type, amount: amount)
                        if type == "Personal"{
                            personalExpenses.items.append(item)
                        }else{
                            bussinesExpenses.items.append(item)
                        }
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationBarBackButtonHidden()
         
        }
    }
}

#Preview {
    AddViewIExpense(personalExpenses: Expenses(), bussinesExpenses: Expenses())
}
