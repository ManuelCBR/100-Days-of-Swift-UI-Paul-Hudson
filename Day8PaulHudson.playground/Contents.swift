import UIKit

//Functions 2
//Default values for parameters

func employee (name: String, mobile: String = "No Number"){ //No number is a default value
    
    print("Name: \(name)\nMobile: \(mobile)")
    
}
employee(name: "Manuel", mobile: "600-955-844")
employee(name: "Patricia")

//To handle errors in functions

enum PasswordError: Error {
    case short, obvious
}
func checkPassword (_ password: String) throws -> String{
    if password.count < 5 {throw PasswordError.short}
    if password == "12345" {throw PasswordError.obvious}
    
    if password.count < 8 {
        return "OK"
    } else if password.count < 10 {
        return "Good"
    } else {
        return "Excellent"
    }
}
do{
    try checkPassword("12345")
}catch PasswordError.short{
    print("The passwor is very short")
}catch PasswordError.obvious{
    print("Use a more complex password")
}catch{
    print("There was an error")
}

//Checkpoint 4
//Write a function that accepts an integer from 1 through 10,000, and returns the integer square root of that number

enum SizeError: Error{
    case outOfBound
}
func square (number: Int) throws -> Int{
    let value = Double(number)
    let squareOfNumber = sqrt(value)
    if number < 1 || number > 10000 {
        throw SizeError.outOfBound
    } else{
        return Int(squareOfNumber)
    }
}
do{
    try print(square(number: 10000))
} catch SizeError.outOfBound{
    print("The number is out of bound")
}

