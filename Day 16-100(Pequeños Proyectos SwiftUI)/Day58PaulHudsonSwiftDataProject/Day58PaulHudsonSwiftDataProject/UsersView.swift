//
//  UsersView.swift
//  Day58PaulHudsonSwiftDataProject
//
//  Created by Manuel Bermudo on 6/7/24.
//

import SwiftData
import SwiftUI

struct UsersView: View {
    
    @Environment (\.modelContext) var modelContext
    
    @Query var users: [User]
    
    var body: some View {
        List(users){user in
            
            HStack{
                Text(user.name)
                Spacer()
                Text(String(user.jobs.count))
                    .fontWeight(.black)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(.blue)
                    .foregroundStyle(.white)
                    .clipShape(.circle)
            }
        }
        .onAppear(perform: addSample)
    }
    
    init(minimunJoinDate: Date, sortOrder: [SortDescriptor<User>]) {
        _users = Query(filter: #Predicate<User>{user in
            user.joinDate >= minimunJoinDate
        }, sort: sortOrder)
    }
    func addSample() {
        let user1 = User(name: "Patricia", city: "Wakanda", joinDate: .now)
        let job1 = Job(name: "Black Panther", priority: 3)
        let job2 = Job(name: "Super Hero", priority: 4)
        
        modelContext.insert(user1)
        
        user1.jobs.append(job1)
        user1.jobs.append(job2)
    }
}

#Preview {
    UsersView(minimunJoinDate: .now, sortOrder: [SortDescriptor(\User.name)])
        .modelContainer(for: User.self)
}
