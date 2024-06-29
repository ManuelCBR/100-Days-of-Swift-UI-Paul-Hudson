import UIKit

//Structs
struct Motorbike{
    let brand: String
    let model: String
    let cc: Int
    
    func printMotorbike() {
        print("""
            Brnd: \(brand)
            Model: \(model)
            Displacement: \(cc)cc
            """)
    }
}
let moto1 = Motorbike(brand: "Honda", model: "CBR 600 f4i", cc: 600)
let moto2 = Motorbike(brand: "Suzuki", model: "GSX-R 600", cc: 600)

moto1.printMotorbike()
moto2.brand

struct Employee {
    let name: String
    var vacationRemaining: Int
    
    mutating func takeVacation(days: Int) {
        if vacationRemaining > days {
            vacationRemaining -= days
            print("i'm going on vacaion")
            print("Days remaning: \(vacationRemaining)")
        }else{
            print("There are not enough days remaining")
        }
    }
    
}
var chef = Employee(name: "Chef", vacationRemaining: 14)

chef.takeVacation(days: 5)
print(chef.vacationRemaining)

//To compute property values dynamically
struct VacationEmployees{
    let name: String
    var vacationAllocated = 14
    var vacationTaken = 0
    
    var vacationRemaining: Int{
        get {
            vacationAllocated - vacationTaken
        }
        set {
            vacationAllocated = vacationTaken + newValue
        }
        
    }
}

var newChef = VacationEmployees(name: "New Chef", vacationAllocated: 14)
newChef.vacationTaken += 4
newChef.vacationRemaining = 5
print(newChef.vacationAllocated)

//Take action when a property changes
struct CounterVisitors{
    var visitors = 0 {
        didSet{
            print("There are \(visitors) visitors")
        }
    }
}
var visitors = CounterVisitors()
visitors.visitors += 10
visitors.visitors -= 3
visitors.visitors += 1

struct App {
    var contacts = [String]() {
        willSet{
            print("Current value is: \(contacts)")
            print("New value will be \(newValue)")
        }
        didSet{
            print("There are now \(contacts.count) contacts")
            print("Old value was: \(oldValue)")
        }
    }
}
var app = App()
app.contacts.append("Manuel")
app.contacts.append("Patricia")
app.contacts.append("Fatima")

//Customs initializers
struct Player{
    let name: String
    let number: Int
    
    init(name: String) {
        self.name = name
        number = Int.random(in: 1...99)
    }
}
let player = Player(name: "Manuel")
print(player.number)



