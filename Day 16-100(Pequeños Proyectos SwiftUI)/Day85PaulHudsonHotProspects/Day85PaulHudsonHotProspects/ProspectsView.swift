//
//  ProspectsView.swift
//  Day85PaulHudsonHotProspects
//
//  Created by Manuel Bermudo on 5/9/24.
//

import CodeScanner
import Foundation
import SwiftData
import SwiftUI
import UserNotifications

struct ProspectsView: View {
    
    enum FilterType {
        case none, contacted, uncontacted
    }
    let filter: FilterType
    
    @Environment(\.modelContext) var modelContext
    @Query var prospects: [Prospect]
    @State private var isShowingScanner = false
    @State private var selectedProspects = Set<Prospect>()
    @State private var sortedByName = true

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
    
    //Challenge 3
    var sortedProspects: [Prospect] {
        prospects.sorted {
            sortedByName ? $0.name < $1.name : $0.creationDate > $1.creationDate
        }
    }
    
    var body: some View {
        NavigationStack{
            //Challenge 3
            List(sortedProspects, selection: $selectedProspects) {prospect in
                NavigationLink { //Challenge 2
                    EditUserView(prospect: prospect)
                } label: {
                    HStack{
                        VStack(alignment: .leading){
                            Text(prospect.name)
                                .font(.headline)
                            
                            Text(prospect.emailAddress)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        //Challenge 1
                        if prospect.isContacted {
                            Image(systemName: "person.fill.checkmark")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.green)
                                .frame(width: 30, height: 30)
                        }
                    }
                    .swipeActions{
                        Button("Delete", systemImage: "trash", role: .destructive){
                            modelContext.delete(prospect)
                        }
                        
                        if prospect.isContacted {
                            Button("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark") {
                                prospect.isContacted.toggle()
                            }
                            .tint(.blue)
                        } else {
                            Button("Mark Contacted", systemImage: "person.crop.circle.badge.checkmark") {
                                prospect.isContacted.toggle()
                            }
                            .tint(.green)
                        }
                        Button("Remind Me", systemImage: "bell") {
                            addNotification(for: prospect)
                        }
                        .tint(.orange)
                    }
                    .tag(prospect)
                }
            }
            .navigationTitle(title)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Scan", systemImage: "qrcode.viewfinder"){
                        isShowingScanner = true
                    }
                }
                
                //Challenge 3
                ToolbarItem(placement: .topBarLeading){
                    Button("Switch", systemImage: "arrow.up.arrow.down"){
                        sortedByName.toggle()
                    }
                }
                
                if selectedProspects.isEmpty == false {
                    ToolbarItem(placement: .bottomBar){
                        Button("Delete Selected", action: delete)
                    }
                }
            }
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "Manuel bermudo\nmanuel@hackingwithswift.com", completion: handleScan)
            }
        }
        .modelContainer(for: Prospect.self)
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
    
    func handleScan(result: Result<ScanResult, ScanError>){
        isShowingScanner = true
        
        switch result {
            case .success(let result):
                let details = result.string.components(separatedBy: "\n")
                guard details.count == 2 else { return }

                let person = Prospect(name: details[0], emailAddress: details[1], isContacted: false)
                modelContext.insert(person)
            case .failure(let error):
                print("Scanning failed: \(error.localizedDescription)")
        }
    }
    
    func delete(){
        for prospect in selectedProspects {
            modelContext.delete(prospect)
        }
    }
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default

            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else if let error {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}

#Preview {
    ProspectsView(filter: .none)
        .modelContainer(for: Prospect.self)
}
