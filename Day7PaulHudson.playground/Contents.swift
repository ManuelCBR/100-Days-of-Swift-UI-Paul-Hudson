import UIKit

//Functions
func timeTables(number: Int){
    for i in 1...10{
        print("\(i) * \(number) = \(i * number)")
    }
}

timeTables(number: 8)

let root = sqrt(150)

//Return Exercise
let string1 = "abcdefghyjk"
let string2 = "kjyhgfedcba"

func theSameString (word1: String, word2: String) -> Bool{
    if (word1.sorted() == word2.sorted()){
        return true
    } else {return false}
}

theSameString(word1: string1, word2: string2)
// Paul's choice of exercise
func areLettersIdentical(string1: String, string2: String) -> Bool{
    string1.sorted() == string2.sorted() //It's not necesary the return if the function has only one line
}
areLettersIdentical(string1: "acb", string2: "cba")

//Return multiple values
func getEmployee () -> (name: String, job: String ){
    (name: "Manuel", job: "Developer")
}
let (name, job) = getEmployee()
print("My name is \(name) and my job is \(job)")

//Customize parameter labels
func timesTable (_ number:Int){ //Yoy can add a underscore to omit de parameter's name in the function call
    for i in 1...10{
        print("\(i) x \(number) = \(i * number)")
    }
}
timesTable(5) //The function call without the parameter's name

func timesTable2 (for number:Int){
    for i in 1...10{
        print("\(i) x \(number) = \(i * number)")
    }
}
timesTable2(for: 7) //You can customize the parameters to call them whatever you want
