import UIKit

//Closures

func user(){
    print("I'm a user")
}
var userCopy = user //When you asign a function to a variable, it's not parentheses
var userCopy2: () -> Void = user //That is how functions have types

userCopy() //The parentheses are included in the variable

let sayHello = { //This is a great closure. This function has not name, but has been assigned directly to a variable
    print("Hello!")
}
sayHello()

let sayHelloUser = { (name: String) -> String in //Here with a parameter and the return
    "Hi!, mi name is \(name)"
}
print(sayHelloUser("Manuel"))

func nameUserById (for id: Int) -> String{
    if (id == 1234){
        return "Manuel"
    }else{
        return "User not found"
    }
}

let nameUser: (Int) -> String = nameUserById
print("The user is: " + nameUser(1234)) //The parameter's name, "for", here has gone

let family = ["Manuel", "Angeles", "Fatima", "Patricia", "Carmen"]
let sortedFamily = family.sorted()

func wifeFirstSorted (name1: String, name2: String) -> Bool{
    if (name1 == "Patricia"){
        return true
    }else if name2 == "Patricia"{
        return false
    }
    return name1 < name2
}
//let wifeFirst = family.sorted(by: wifeFirstSorted)
//print(wifeFirst)

let wifeFirst = family.sorted(by: { (name1: String, name2: String) -> Bool in //Here the closure 🤯
    if name1 == "Patricia"{
        return true
    }else if name2 == "Patricia"{
        return false
    }
    return name1 < name2
})
print(wifeFirst)

//Trailing closures and shorthand syntax
let wifeFirst2 = family.sorted {
    if $0 == "Patricia"{ //Element 1
        return true
    }else if $1 == "Patricia"{ //Element2
        return false
    }
    return $0 < $1
}
let reverseWife = family.sorted { $0 > $1 }
print(wifeFirst)

let cOnly = family.filter{$0.hasPrefix("C")}
print(cOnly)
let uppercaseFamily = family.map{$0.uppercased()}
print(uppercaseFamily)

//Functions as parameters
func hiUser(){
    print("Hi user!")
}
hiUser()
var hiCopy: () -> Void = hiUser
hiCopy()

func makeArray(size: Int, using generator: () -> Int) -> [Int]{
    var numbers = [Int]()
    
    for _ in 0..<size{
        let newNumber = generator()
        numbers.append(newNumber)
    }
    return numbers
}
func generateNumber() -> Int{
    Int.random(in: 1...20)
}
let newRolls = makeArray(size: 50, using: generateNumber)
print(newRolls)

func doImportantWork(first: () -> Void, second: () -> Void, third: () -> Void){
    print("About to start first work")
    first()
    print("About to start second work")
    second()
    print("About to start third work")
    third()
    print("Done!")
}

doImportantWork {
    print("First Work")
} second: {
    print("Second Work")
} third: {
    print("Third Work")
}

func test1(){
    print("New First Work")
}
func test2(){
    print("New Second Work")
}
func test3(){
    print("New Third Work")
}
doImportantWork(first: test1, second: test2, third: test3) //Also you can add the functions as parameters like this if you have them

//CheckPoint 5
let luckyNumbers = [7, 4, 38, 21, 16, 15, 12, 33, 31, 49]
//Part 1.  Filter out any numbers that are even
let evenLuckyNumbers = luckyNumbers.filter{$0 % 2 == 0}
print("Only the even numbers: \(evenLuckyNumbers)")
//Part 2. Sort the array in ascending order
var sortedluckyNumbers = luckyNumbers.sorted{$0 < $1}
print("LuckyNumbers sorted: \(sortedluckyNumbers)")
//Part 3. Map them to strings in the format “7 is a lucky number”
let sortedLuckyNumbersString = sortedluckyNumbers.map{"\($0) is a lucky number"}
for string in sortedLuckyNumbersString{
    print(string)
}


