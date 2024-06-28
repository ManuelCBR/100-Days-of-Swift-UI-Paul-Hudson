import UIKit

//Type annotations

let name: String = "Manuel"
let age: Int = 36
var actors: [String] = ["Dwayne Jhonson", "Kevin Hart", "Will Smith"]
var user: [String: String] = ["id": "@ManuCBR"]
var motorbikes: Set<String> = Set(["Honda", "Yamaha", "Suzuki"])

//CheckPoint2 (Create an array of string, then write some code that prints the number of items in the array and also the number of unique items in the array)

let shopingList: [String] = ["Potatoes", "Tomatoes", "Orange juice", "Coffe", "Tomatoes", "steak", "Milk", "Lemon", "Rice", "Orange juice", "Milk"]
print("The Array has \(shopingList.count) elements")
//A set is created to eliminate duplicate elements
let shopingListWithoutDuplicates: Set<String> = Set(shopingList)
print("The Array hat \(shopingListWithoutDuplicates.count) elements without duplicates")

