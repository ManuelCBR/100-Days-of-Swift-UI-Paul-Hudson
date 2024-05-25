import UIKit

//Classes
class Game {
    var score = 0{
        didSet {
            print("Score is now \(score)")
        }
    }
}
var newGame = Game()
newGame.score += 10

//Inheritance
class Employee{
    let hours: Int
    init(hours: Int){
        self.hours = hours
    }
    func printSummary(){
        print("I work \(hours) hours a day")
    }
}
final class Developer: Employee{ //If it's declared as final, it cannot be inherited by another class
    func work(){
        print("I'm writing code for \(hours)")
    }
    
    override func printSummary() {
        print("I'm a developer who will work \(hours) hours a day (sometimes)")
    }
}
final class Manager: Employee{
    func work(){
        print("I'm going to meetings for \(hours)")
    }
}
let employee1 = Developer(hours: 6)
let employee2 = Manager(hours: 8)
employee1.work()
employee2.work()
employee1.printSummary()

//Initializers for classes
class Computer {
    let hasMacOS: Bool
    init(hasMacOS: Bool) {
        self.hasMacOS = hasMacOS
    }
}
class Mac: Computer{
    let isLaptop = true
}

let macbookAir = Mac(hasMacOS: true)

//How to copy classes
class Motorbike{
    var brand = "Unknow"
    func copy() -> Motorbike{ //We can safely call copy() to get an object with the same starting data, but any future changes won’t impact the original
        let motorbike = Motorbike()
        motorbike.brand = brand
        return motorbike
    }
}
var moto1 = Motorbike()
var moto2 = moto1
moto2.brand = "Honda"
print(moto1.brand)
print(moto2.brand)

//How to create a deinitializer for a class
class App{
    let id: Int
    init(id: Int) {
        self.id = id
        print("App \(id): I'm ON")
    }
    deinit{ //It has not parentheses
        print("App \(id): I'm OFF")
    }
}

var apps = [App]()
for i in 1...4{
    let app = App(id: i)
    print("App \(app.id): Working")
    apps.append(app)
}
print("Loop is finished")
apps.removeAll()
print("Array is clear")

//Work with variables inside classes
class User {
    var name = "Manuel"
}

var user = User()
user.name = "Patricia"
print(user.name)
user = User()
print(user.name)

//CheckPoint 7
/*Your challenge is this: make a class hierarchy for animals, starting with Animal at the top, then Dog and Cat as subclasses, then Corgi and Poodle as subclasses of Dog, and Persian and Lion as subclasses of Cat.
 But there’s more:

 1. The Animal class should have a legs integer property that tracks how many legs the animal has.
 2. The Dog class should have a speak() method that prints a generic dog barking string, but each of the subclasses should print something slightly different.
 3. The Cat class should have a matching speak() method, again with each subclass printing something different.
 4. The Cat class should have an isTame Boolean property, provided using an initializer.
 */

class Animal{
    var legs: Int
    init(legs: Int = 4) {
        self.legs = legs
    }
}
class Dog: Animal{
    func speak(){
        print("The dogs usually bark")
    }
}
class Cat: Animal{
    var isTame: Bool
    func speak(){
        print("The cats usually meow")
    }
    init(legs: Int, isTame: Bool) {
        self.isTame = isTame
        super.init(legs: legs)
    }
}
class Corgi: Dog{
    override func speak() {
        print("The Corgi goes Woof Woof")
    }
}
class Poodle: Dog{
    override func speak() {
        print("The Poodle goes Bark Bark")
    }
}
class Persian: Cat{
    override func speak() {
        print("The persian goes meow")
    }
}
class Lion: Cat{
    override func speak() {
        print("The Lion goes Grrrrr")
    }
}
var superDog = Dog()
superDog.speak()
var superCat = Cat(legs: 4, isTame: true)
superCat.speak()
var dog1 = Corgi()
dog1.speak()
print("The Corgi has \(dog1.legs) legs")
var dog2 = Poodle()
dog2.speak()
print("The Poodle has \(dog2.legs) legs")
var cat1 = Persian(legs: 4, isTame: true)
cat1.speak()
print("The Persian is tame: \(cat1.isTame)")
var cat2 = Lion(legs: 4, isTame: false)
cat2.speak()
print("The Lion is tame: \(cat1.isTame)")
