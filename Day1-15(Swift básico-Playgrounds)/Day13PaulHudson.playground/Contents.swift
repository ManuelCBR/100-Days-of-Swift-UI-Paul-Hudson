import UIKit

//Protocols
protocol Vehicle {
    var name: String {get}
    var currentPassengers: Int{get set}
    func estimatedTime(for distance: Int) -> Int
    func travel(distance: Int)
}
struct Car: Vehicle{
    var name = "Car"
    var currentPassengers = 4
    //All the methods we listed in Vehicle must exist exactly in Car
    func estimatedTime(for distance: Int) -> Int {
        distance / 50
    }
    func travel(distance: Int) {
        print("I'm driving \(distance)kms")
    }
    func openSunroof(){ //But yo can create func extra
        print("It's a nice day")
    }
}
struct Bicycle: Vehicle {
    let name = "Bicycle"
    var currentPassengers = 1
    func estimatedTime(for distance: Int) -> Int {
        distance / 10
    }
    func travel(distance: Int) {
        print("I'm cycling \(distance)kms")
    }
}
func commute(distance: Int,using vehicle: Vehicle){
    if vehicle.estimatedTime(for: distance) > 100 {
        print("I have to try a different vehicle")
    } else {
        vehicle.travel(distance: distance)
    }
}
func getTravelEstimates(using vehicles: [Vehicle], distance: Int){
    for vehicle in vehicles {
        let estimate = vehicle.estimatedTime(for: distance)
        print("\(vehicle.name): \(estimate) hours to travel \(distance)kms")
    }
}
let car = Car()
commute(distance: 220, using: car)
let bike = Bicycle()
commute(distance: 60, using: bike)

getTravelEstimates(using: [car, bike], distance: 150)

//Opaque return types
func getRandomNumber() -> some Equatable{
    Double.random(in: 1...10)
}
func getRandomBool() -> some Equatable{
    Bool.random()
}
print(getRandomNumber() == getRandomNumber())

//Extensions
var quote = "   There are many spaces   "
let trimmed = quote.trimmingCharacters(in: .whitespacesAndNewlines)

extension String {
    func trimmed() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    mutating func trim(){
        self = self.trimmed()
    }
    var line: [String]{
        self.components(separatedBy: .newlines)
    }
}
quote.trim()
let text = """
Hi, this is a line
And this another line
And one more line
"""
print(text.line.count)

struct Motorbike{
    let brand: String
    let hp: Int
    let yearsON: Int
}
extension Motorbike{ //if the initializer is created inside the struct, you cannot set the parameter to the instance.
    init(brand: String, hp: Int) { //Must be created in an extension
        self.brand = brand
        self.hp = hp
        self.yearsON = 5
    }
}
let motorbike = Motorbike(brand: "Honda CBR 600 F4i", hp: 110, yearsON: 2001)

//Protocol extensions
extension Collection{
    var isNotEmpty: Bool{
        isEmpty == false
    }
}
let guest = ["Manuel", "Patricia", "Fatima"]
if guest.isNotEmpty{
    print("Guest count: \(guest.count)")
}

protocol User {
    var name: String {get}
    func sayHi()
}
extension User{
    func sayHi() {
        print("Hi everyone!")
    }
}
struct MacUser: User{
    var name: String
}
let macUser = MacUser(name: "Manuel")
macUser.sayHi()

//CheckPoint 8
/* Make a protocol that describes a building, adding various properties and methods, then create two structs, House and Office, that conform to it. Your protocol should require the following:
 
1. A property storing how many rooms it has.
2. A property storing the cost as an integer (e.g. 500,000 for a building costing $500,000.)
3. A property storing the name of the estate agent responsible for selling the building.
4. A method for printing the sales summary of the building, describing what it is along with its other properties.
 */
protocol Building{
    var rooms: Int { get }
    var cost: Int { get }
    var nameAgent: String { get }
    func summary()
}
extension Building{
    func summary(){
        print(
            """
            Cost: \(cost)
            Rooms: \(rooms)
            Agent Name: \(nameAgent)
            """)
    }
}
struct House: Building{
    var rooms: Int
    var cost: Int
    var nameAgent: String
}
struct Office: Building{
    var rooms: Int
    var cost: Int
    var nameAgent: String
}
let house = House(rooms: 5, cost: 300_000, nameAgent: "Manuel")
let office = Office(rooms: 7, cost: 500_000, nameAgent: "Patricia")
house.summary()
office.summary()
