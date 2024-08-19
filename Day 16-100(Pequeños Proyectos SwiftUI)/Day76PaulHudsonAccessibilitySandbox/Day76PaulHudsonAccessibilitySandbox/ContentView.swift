//
//  ContentView.swift
//  Day76PaulHudsonAccessibilitySandbox
//
//  Created by Manuel Bermudo on 15/8/24.
//

/**
 One of the best ways to learn is to write your own code as often as possible, so here are three ways you should try extending this app to make sure you fully understand what’s going on.
 - 1. The check out view in Cupcake Corner uses an image and loading spinner that don’t add anything to the UI, so find a way to make the screenreader not read them out.
 - 2. Fix the list rows in iExpense so they read out the name and value in one single VoiceOver label, and their type in a hint.
 - 3. Do a full accessibility review of Moonshot – what changes do you need to make so that it’s fully accessible?
 */

import SwiftUI

struct TextViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 200, height: 60)
            .foregroundStyle(.white)
            .background(.lightBackground)
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
extension View {
    func customTextStyle() -> some View {
            self.modifier(TextViewModifier())
        }
}

struct ContentView: View {
    var body: some View {
        
        NavigationStack {
            VStack{
                Text("Day 76 Paul Hudson")
                    .font(.title)
                    .bold()
                    .foregroundStyle(.blue)
                    .padding(.top, 100)
                Text("Challenge day")
                    .font(.title)
                    .bold()
                    .foregroundStyle(.blue)
                Text("This includes 3 previous apps to be able to carry out Paul Hudson's day 76 challenge and to be able to have the modifications he requests in them and thus be able to see them in just one place.")
                    .font(.title2)
                    .foregroundStyle(.orange)
                    .padding(.horizontal, 20)
                    .padding(.top, 80)
                Spacer()
                
                NavigationLink {
                    CupcakeCornerView()
                } label: {
                    Text ("CupcakeCorner")
                        .customTextStyle()
                }
                
                NavigationLink{
                    IExpenseView()
                } label: {
                    Text ("iExpense")
                        .customTextStyle()
                }
                .customTextStyle()
                
                NavigationLink{
                    MoonShot()
                } label: {
                    Text ("MoonShot")
                        .customTextStyle()
                }
                .customTextStyle()
                
                Spacer()
            }
            .background(.darkBackground)
        }
    }
}

#Preview {
    ContentView()
}
