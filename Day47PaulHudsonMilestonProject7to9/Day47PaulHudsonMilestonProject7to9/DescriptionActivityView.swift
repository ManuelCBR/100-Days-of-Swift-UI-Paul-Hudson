//
//  DescriptionActivityView.swift
//  Day47PaulHudsonMilestonProject7to9
//
//  Created by Manuel Bermudo on 26/6/24.
//

import SwiftUI

struct DescriptionActivityView: View {
    
    var activities: Activities
    
    var descriptions: Activity
    
    
    
    
    var body: some View {
        NavigationStack{
            ZStack{
                LinearGradient(colors: [.yellow, .orange], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                VStack{
                    HStack{
                        Text("\(descriptions.description)")
                            .font(.title2)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                        Spacer()
                    }
                    Spacer()
                    VStack(alignment: .center){
                        Text("Complete \(descriptions.completionCount) times")
                            .font(.title2)
                        Button(action: {
                            incrementActivityCount()
                        }, label: {
                            Text("Add it one more time")
                                .foregroundStyle(.black)
                            Spacer()
                                .frame(width: 50)
                            Spacer()
                                .frame(width: 50)
                            Image(systemName: "plus")
                                .clipShape(Circle())
                                .foregroundStyle(Color.black)
                        })
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(#colorLiteral(red: 1, green: 0.6632267833, blue: 0, alpha: 1)))
                                .shadow(radius: 5)
                        )
                        Spacer()
                            .frame(height: 30)
                    }
                }
            }
            .navigationTitle("\(descriptions.name)")
            .preferredColorScheme(.light)
        }
        
    }
    func incrementActivityCount() {
            if let index = activities.activities.firstIndex(of: descriptions) {
                var newActivity = descriptions
                newActivity.completionCount += 1
                activities.activities[index] = newActivity
            }
        }
}

#Preview {
    let descriptionActivity = Activity(name: "Activity 1", description: "Description 1")
    return DescriptionActivityView(activities: Activities(), descriptions: descriptionActivity)
}
