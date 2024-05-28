import UIKit

//Optionals
//How to use if let to unwarp optionals
var user: String? = nil

//Use if let to unwrap optionals so you can process them somehow
if let userName = user {
    print("There is a user: \(userName)")
}else{
    print("The optional is empty")
}

func square(number: Int) -> Int{
    number * number
}

var number: Int? = nil

if let number = number{
    //number is valid here inside
    print(square(number: number))
}

//How to use guard let to unwarp optionals
func printSquare (number: Int?){
    //Use guard let to ensure optionals have something inside them and exit otherwise
    guard let num = number else{
        print("Missing input")
        return
    }
    print("\(num) x \(num) is \(num * num)")
}

//How to unwrap optionals with nil coalescing
let capitains = [
    "Enterprise": "Picard",
    "Voyager": "Janeway",
    "Defiant": "Sisko"
]
let newCapitain = capitains["Serenity"] ?? "N/A"

let brands = ["Honda", "BMW", "Porsche", "Mercedes"]
let favouriteBrand = brands.randomElement() ?? "None"
print(favouriteBrand)

struct User {
    let title: String
    let name: String?
}
let userVIP = User(title: "1", name: nil)
let name = userVIP.name ?? "Unknown"

let input = ""
let newNumber = Int(input) ?? 0
print(newNumber)

//How to handle multiple optionals using optional chaining
let cities = ["Sevilla", "Cordoba", "Malaga"]
let chosen = cities.randomElement()?.uppercased() ?? "No one" //If the optional has value inside, unwrap it then
print("Next in line: \(chosen)")

struct Book {
    let title: String
    let author: String?
}
var book: Book? = nil
let author = book?.author?.first?.uppercased() ?? "A"
print(author)

//How to handle function failure with optionals
enum UserError: Error{
    case wrongId, networkFailed
}
func getUser(id: Int) throws -> String {
    throw UserError.networkFailed
}
if let user1 = try? getUser(id: 40) {
    print("User: \(user1)")
}
let user1 = (try? getUser(id: 23)) ?? "Unknown"
print(user1)

//CheckPoint 8
/*
 Write a function that accepts an optional array of integers, and returns one randomly. If
 the array is missing or empty, return a random number in the range 1 through 100
 Write your function in a single line of code
 */
func randomNumber (arr: [Int]?) -> Int {arr?.randomElement() ?? Int.random(in: 1...100)}
