import UIKit

//Booleans
let thisIsABolean = true

var isAuthenticated = false

isAuthenticated = !isAuthenticated
print(isAuthenticated)

var gameOver = false
print(gameOver)
gameOver.toggle() //Cambia a su valor contrario
print(gameOver)

//Strings together
let firstPart = "This is the first part of the sentence. "
let secondPart = "this is the second part"
let greeting = firstPart + secondPart
print(firstPart + "And " + secondPart)

let name = "Manuel"
let age = 36
print("My name is \(name) and I'm \(age)")
print("10 x 10 is \(10 * 10)")

//CheckPoint1 (Converter temperatures from Celsius to Fahrenheit)
let celsius = 25.0
let fahrenheit = (celsius * 9) / 5 + 32
print("The temperature in ºC is \(celsius)ºC and in ºF is \(fahrenheit)ºF")
