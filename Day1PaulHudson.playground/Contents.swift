import UIKit

//Variables and constants

var name = "Manuel"
name = "Patricia"
name = "Paul"

let character = "John" // Puede cambiar

var playerName = "Bishop"
print(playerName)

playerName = "Samantha"
print(playerName)

//Strings
let actor = "Dwayne Jhonson"
let image = "cbr600f4.jpg"
let emoji = "😄 happy 😄"
let quote = "Ante la duda, \"gas\"!"

let multiLine = """
This is an example
of a multiline
string
"""
print(actor.count)
print(quote.uppercased())
print(multiLine.hasPrefix("This"))
print(image.hasSuffix(".jpg"))

//Int Numbers
let score = 10
let reallyBig = 100_000_000 //Swift ignora estos guiones bajos

let lowerScore = score - 5
let higherScore = score + 5
let doubledScore = score * 2
let squaredScore = score * score
let halvedScore = score / 2

var counter = 20
counter += 5
counter *= 2
counter -= 10

print(counter.isMultiple(of: 5))

// Decimal numbers

let number = 0.1 + 0.2
print(number)

let double1 = 3.1
let double2 = 3221.234
let double3 = 3.0
let int1 = 3

var rating = 5.0
rating *= 2
