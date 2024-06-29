//
//  ContentView.swift
//  Day46PaulHudsonNavigation
//
//  Created by Manuel Bermudo on 24/6/24.
//

import SwiftUI
/**
 Challenge
 One of the best ways to learn is to write your own code as often as possible, so here are three ways you should try extending this app to make sure you fully understand what’s going on.
 - 1. Change project 7 (iExpense) so that it uses NavigationLink for adding new expenses rather than a sheet. (Tip: The dismiss() code works great      here, but you might want to add the navigationBarBackButtonHidden() modifier so they have to explicitly choose Cancel.)
 - 2. Try changing project 7 so that it lets users edit their issue name in the navigation title rather than a separate textfield. Which option do you prefer?
 - 3. Return to project 8 (Moonshot), and upgrade it to use NavigationLink(value:). This means adding Hashable conformance, and thinking carefully how to use navigationDestination().
 */

struct ContentView: View {

    var body: some View {
        NavigationStack{
            ZStack{
                LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                VStack{
                    Text("Challenge day 46")
                        .font(.title.bold())
                    Text("Change project 7 and 8")
                        .font(.title.bold())
                    Spacer()
                        .frame(height: 300)
                    
                    NavigationLink("Go to project 7 \n (iExpense) to view \n the Challenge 1 and 2"){
                        IExpenseContentView()
                    }
                    .frame(width: 250, height: 100)
                    .font(.title3.bold())
                    .foregroundColor(.black)
                    .background(.blue)
                     .cornerRadius(20)
                    Spacer()
                        .frame(height: 50)
                    NavigationLink("Go to project 8 \n (Moonshot) to view \n the Challenge 3"){
                        MoonshootView()
                    }
                    .frame(width: 250, height: 100)
                    .font(.title3.bold())
                    .foregroundColor(.black)
                    .background(.blue)
                    .cornerRadius(20)
                }
            }
        }
    }
    
}

#Preview {
    ContentView()
}
