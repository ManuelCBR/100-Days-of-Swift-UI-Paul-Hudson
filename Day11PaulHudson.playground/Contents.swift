import UIKit

//How to limit access to internal data using access control
struct BankAcount{
    private(set) var funds = 0
    mutating func deposit(amount: Int){
        funds += amount
    }
    mutating func withdraw(amount: Int) -> Bool{
        if funds > amount {
            funds -= amount
            return true
        }else{
            return false
        }
    }
}
var account = BankAcount()
account.deposit(amount: 100)
let success = account.withdraw(amount: 200)

if success{
    print("Whitdrew money successfuly")
}else{
    print("Falied to get money")
}

//Static properties and metods
struct MotoGP{
    static var pilotCount = 0
    static func add(pilot: String){
        print("\(pilot) has been added to the MotoGP list")
        pilotCount += 1
    }
}

MotoGP.add(pilot: "Marc Márquez")
print(MotoGP.pilotCount)

struct Pilot{
    let name: String
    let number: Int
    let height: String
    
    static let example = Pilot(name: "Marc Marquez", number: 93, height: "168 cm")
}
print(Pilot.example)

//CheckPoint 6
/*Create a struct to store information a car. Include:
 -Its model
 -Number of seats
 -Current gear
 Add a method to change gears up or down
 Have a think about variables and access control
 Don't allow invalid gears - 1...10 seems a fair maximun range
 */
struct Car{
    let model: String
    let seats: Int
    var currentGear: Int
    
    mutating func changeGear(gear: Int){
        if gear > 0 && gear <= 10 {
            currentGear = gear
        }else{
            print("You have tried to change the gear but this gear is not allowed")
        }
    }
    static let example = Car(model: "Porsche Boxter", seats: 2, currentGear: 2)
}
print(Car.example)
var mustang = Car(model: "Mustang", seats: 4, currentGear: 3)
print("The model of car is: \(mustang.model)")
print("The number of seats are: \(mustang.seats)")
print("The current gear is: \(mustang.currentGear)")
mustang.changeGear(gear: 12)
print("Now the current gear is: \(mustang.currentGear)")
mustang.changeGear(gear: 5)
print("Now the current gear is: \(mustang.currentGear)")
