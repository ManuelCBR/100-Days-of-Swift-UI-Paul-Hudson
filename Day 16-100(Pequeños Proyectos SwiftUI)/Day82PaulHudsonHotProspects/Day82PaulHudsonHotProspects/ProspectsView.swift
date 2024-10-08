//
//  ProspectsView.swift
//  Day82PaulHudsonHotProspects
//
//  Created by Manuel Bermudo on 4/9/24.
//

import SwiftData
import SwiftUI

struct ProspectsView: View {
    
    enum FilterType {
        case none, contacted, uncontacted
    }
    let filter: FilterType
    
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Prospect.name) var prospects: [Prospect]
    
    var title: String {
        switch filter {
            case .none:
                "Everyone"
            case .contacted:
                "Contacted people"
            case .uncontacted:
                "Uncontacted people"
        }
    }
    
    var body: some View {
        NavigationStack{
            List(prospects) {prospect in
                VStack(alignment: .leading){
                    Text(prospect.name)
                        .font(.headline)
                    
                    Text(prospect.emailAddress)
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle(title)
            .toolbar {
                Button("Scan", systemImage: "qrcode.viewfinder"){
                    let prospect = Prospect(name: "Manuel Bermudo", emailAddress: "manuelB@gmail.com", isContacted: false)
                    modelContext.insert(prospect)
                }
            }
        }
    }
    
    init(filter: FilterType) {
        self.filter = filter
        
        if filter != .none {
            let showContactedOnly = filter == .contacted
            
            _prospects = Query(filter: #Predicate {
                $0.isContacted == showContactedOnly
            }, sort: [SortDescriptor(\Prospect.name)])
        }
    }
}

#Preview {
    ProspectsView(filter: .none)
        .modelContainer(for: Prospect.self)
}
