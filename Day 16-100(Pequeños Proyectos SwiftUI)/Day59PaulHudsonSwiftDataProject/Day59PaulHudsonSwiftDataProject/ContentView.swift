//
//  ContentView.swift
//  Day59PaulHudsonSwiftDataProject
//
//  Created by Manuel Bermudo on 7/7/24.
//

import SwiftData
import SwiftUI

/**
 Challenge
 One of the best ways to learn is to write your own code as often as possible, so here are three ways you should try extending this app to make sure you fully understand what’s going on.
 All three of these challenges relate to you upgrade project 7, iExpense:
 - 1. Start by upgrading it to use SwiftData.
 - 2. Add a customizable sort order option: by name or by amount.
 - 3. Add a filter option to show all expenses, just personal expenses, or just business expenses.
 */

//Challenge 1 is in all project
struct ContentView: View {
    
    //Challenge 2
    @Environment(\.modelContext) var modelContext
    @State private var showingAddExpense = false
    @State private var showinBussinesExpenses = false

    var body: some View {
        NavigationStack {
            //Challenge 3
            ExpensesView(expenseType: showinBussinesExpenses ? "Bussines" : "Personal")
            .navigationTitle("iExpense")
            .toolbar {
                //Challenge 3
                Button(showinBussinesExpenses ? "Personal" : "Bussines"){
                    showinBussinesExpenses.toggle()
                }
                Button("Add Expense", systemImage: "plus"){
                    showingAddExpense = true
                }
                
            }
            .sheet(isPresented: $showingAddExpense){
                AddView()
            }
        }
    }
}

#Preview {
    ContentView()
}
