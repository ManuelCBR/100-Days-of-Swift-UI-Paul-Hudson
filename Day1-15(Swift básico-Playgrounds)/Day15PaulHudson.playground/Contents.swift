import UIKit

import UIKit
//Consolidation I
//Swift review | Learn essential Swift in one hour

//----- Variables and constants -----
var variable = "This is a variable"
variable = "The variables can change"
let constant = "This is a constant, and I cannot change"

//----- Strings -----
let myString = "This is an one line String"
let myMultpleLineString = """
This is a
multiple line
String
"""
//Below are some examples of predefined functions for String
print(myString.count) //This read how many letters are in the myString string
print(myString.hasPrefix("This")) //Lets us know whether a string starts with specific letters
print(myString.hasSuffix("ing")) //And here lets us know whether a string ends with specific letters
//----- Int -----
let myInt = 5
var myInt1 = myInt + 10
let myInt2 = myInt / 2
var count = 10
count += 5
myInt.isMultiple(of: 5)
let rnd = Int.random(in: 1...20)

//----- Double -----
let myDouble = 5.1
let myDoubleZero = 6.0

//----- Bool -----
let isRed = false
let isBlue = true

//----- Joining strings -----
print("\(myString) and this is a Int: \(myInt)")

//----- Arrays -----
var myArrString = ["String1", "String2", "String3"]
var myArrInt = [1, 2, 3, 4, 5]
let myArrDouble = [1.1, 1.2, 2.3]
print(myArrString[1])
print(myArrInt[3])
myArrString.append("New String") //To add a new value to the array
myArrString.remove(at: 1) //To remove a specific value
print(myArrString.count) //To count how many values are in the array
print(myArrInt.contains(1))//To check if the value exist

//----- Dictionaries -----
let myDictionary = [1: "value1", 2: "value2", 3: "value3"]
print(myDictionary[1, default: "Unknown"])

//----- Sets -----
var mySet = Set([1, 2, 3, 4]) //The set will ignore duplicate values, and it won’t remember the order used in the array
print(mySet)
mySet.insert(5)
print(mySet.contains(7))

//----- Enums -----
enum MyEnum {
    case january, february, march, april //....
}
var myEnum = MyEnum.january
myEnum = .february

//----- Type annotations -----
let myAnnotation: String = "This is a string with type annotation"
let myAnnotationInt: Int = 2
let myAnnotationDouble: Double = 5.3
let myAnnotationBool: Bool = true
let myAnnotationArray: Array<String> = ["Value1", "Value2"]
let myAnnotationDictionary: Dictionary<String, String> = ["key1": "value1", "key2": "Value2"]
var myAnnotationSet: Set<String> = Set(["Value1", "Value2"])
//You can shorten the sintax of Arrays, Dictionaries...
let myShortAnnotationArray: [String] = ["Value1", "Value2"]
let myShortAnnotationDictionary: [String: String] = ["Key1": "Value1", "Key2": "Value2"]
//You can make empty collections
let myEmptyAnnotationArr: [String] = [String]()
let myEmptyArr = [String]()
enum MyAnnotationEnum{
    case Value1, Value2
}
let myAnnotationEnum: MyAnnotationEnum = .Value1

//----- Conditions -----

if myAnnotationInt >= 2{
    print("MyAnnotationInt is greater than 2")
}else if myAnnotationInt == 2{
    print("MyAnnotationInt is 2")
}else{
    print("MyAnnotationInt is less than 2")
}

if myAnnotationInt > 1 && myAnnotationInt < 3 {
    print("myAnnotationInt is 2")
}
if myAnnotationInt > 1 || myAnnotationInt < 3 {
    print("myAnnotationInt is 2")
}

//----- Switch -----
switch myEnum{
    case .april:
        print("It's April")
    case .february:
        print("It's February")
    case .january:
        print("It's January")
    case .march:
        print("It's March")
}

//----- Ternary conditional -----
let myTernary = myAnnotationInt >= 2 ? "Yes" : "No"
print(myTernary)

//----- Loops -----
//For
for myArrStrings in myArrString {
    print(myArrStrings)
}
for i in 1..<11{
    print("5 x \(i) = \(5 * i)")
}
//While
while count >= 0 {
    print(count)
    count -= 1
}
//For with continue
let files = ["me.jpg", "work.txt", "sophie.jpg"]

for file in files {
    if file.hasSuffix(".jpg") == false {
        continue
    }
    print("Found picture: \(file)")
}

//Functions
func withParameter(number: Int){ //With parameter
    for i in 1...10{
        print("\(number) x \(i): \(number * i)")
    }
}
withParameter(number: 5)

func withReturn() -> Int{ //With return
    return Int.random(in: 1...50)
}
print(withReturn())

func withMultipleReturn() -> (return1: String, return2: String){ //With multiple returns
    (return1: "The first return", return2: "The second return")
}
let multipleReturn = withMultipleReturn()
print("This is: \(multipleReturn.return1) and this: \(multipleReturn.return2)")
let (multipleReturn1, _) = withMultipleReturn()
print(multipleReturn1) //If you just want to get a return

func withoutParameterLabel(_ parameter: String) -> Bool{ //So you don't have to specify the name of the parameter in the call
    parameter == parameter.uppercased()
}
let parameterNoLabel = "MANUEL"
print(withoutParameterLabel(parameterNoLabel))

func customizeParameter (for number: Int){//Customize the parameter name
    number * number
}
customizeParameter(for: 5)

func defaultParameters (_ name: String, parameter: Bool = false){ //Parameter by default
    if parameter{
        print("Hi \(name)")
    }else{
        print("Bye \(name)")
    }
}
defaultParameters("Manuel", parameter: true)

enum HandlingError: Error{
    case short, obvious
}
func handError (_ pass: String) throws -> String { //Handling error in a function
    if pass.count < 5{
        throw HandlingError.short
    }
    if pass == "12345"{
        throw HandlingError.obvious
    }
    if pass.count > 10{
        return "OK"
    }else{
        return "Good"
    }
}

do{
    let handErr = try handError("12345")
    print(handErr)
}catch HandlingError.obvious{
    print("I have the same combination")
}catch {
    print("There was an error")
}

//Closures
let myClosure = { (name: String) -> String in
    "Hi \(name), this is my Closure"
}
myClosure("Manuel")

let arrayForClosure = ["Manuel", "Patricia", "Fatima", "Angeles", "Pedro"]
let onlyPClosure = arrayForClosure.filter({(name: String) -> Bool in
    return name.hasPrefix("P")
})
let onlyPClosureShort = arrayForClosure.filter{$0.hasPrefix("P")}
print(onlyPClosure)

//Struct
struct MyStruct{
    let parameter1: String
    let parameter2: String
    let parameter3: String
    var isReleased = true
    
    func printTheStruct(){
        print("1: \(parameter1), 2: \(parameter2), 3: \(parameter3)")
    }
    mutating func removeFromSale(){ //Mutating is able to change a variable in a struct
        isReleased = false
    }
}
let myStruct = MyStruct(parameter1: "Parameter 1", parameter2: "Parameter2", parameter3: "Parameter 3")
print(myStruct.parameter1)
myStruct.printTheStruct()

//Computed properties
struct StructEmployee{
    let name: String
    var vacationAllowed = 14
    var vacationTaken = 0
    
    var vacationRemaining: Int {
        get{
            vacationAllowed - vacationAllowed
        }
        set{
            vacationAllowed = vacationTaken + newValue
        }
    }
}
//Property observers
struct StructGame {
    var score = 0 {
        didSet{
            print("Score is now \(score)")
        }
    }
}
var structGame = StructGame()
structGame.score += 20
structGame.score -= 5

//Customs initializers
struct StructPlayer {
    let name: String
    let number: Int
    
    init(name: String) {
        self.name = name
        number = Int.random(in: 1...50)
    }
}
//Acces Control
struct MyPrivateStruct {
    private(set) var funds = 0 //Modifier Private

    mutating func deposit(amount: Int) {
        funds += amount
    }
    mutating func withdraw(amount: Int) -> Bool {
        if funds > amount {
            funds -= amount
            return true
        } else {
            return false
        }
    }
}
let myPrivate = MyPrivateStruct(funds: 150)
//myPrivate.funds += 200 -> It's not posible because of private modifier

struct MyStaticStruct{
    static let statVar = "This is a static variable"
    static let starVar2 = "This is another static variable"
}
print(MyStaticStruct.statVar) //It's accessible because it's Static

//Classes (There are differences with Structs)
class MyClass{
    let varClas: Int
    
    init(varClas: Int) {
        self.varClas = varClas
    }
    func printMyClass(){
        print("The number choosen by de user is: \(varClas)")
    }
}
class MyClass2: MyClass{ //First Diferent: We can create classes by inheriting functionality from other classes
    func printMyClass2(){
        print("This is de second class, and the number is the same than the Super Class: \(varClas)")
    }
    override func printMyClass() {
        print("This is the function from the Superclass overrided")
    }
}
let myClass = MyClass2(varClas: 20)
myClass.printMyClass()
myClass.printMyClass2()

/**
 The second difference*/

/**
 The second difference. There’s a lot of complexity here, but there are three key points:
 Swift won’t generate a memberwise initializer for classes.
 If a child class has custom initializers, it must always call the parent’s initializer after it has finished setting up its own properties.
 If a subclass doesn’t have any initializers, it automatically inherits the initializers of its parent class.
 */
class MyClass3 {
    let isClass: Bool
    init(isClass: Bool) {
        self.isClass = isClass
    }
}
class MyClass4: MyClass3{
    let isAnotherClass: Bool
    init(isAnotherClass: Bool, isClass: Bool) {
        self.isAnotherClass = isAnotherClass
        super.init(isClass: isClass) //Super allows us to call up to methods that belong to our parent class, such as its initializer
    }
}
//The third difference is that all copies of a class instance share their data, meaning that changes you make to one will automatically change other copies
class MyClass1{
    var myVar = "My variable"
}
var myVarClass1 = MyClass1()
var myVarClass2 = myVarClass1
myVarClass2.myVar = "Different variable than the first"
print(myVarClass1.myVar)
print(myVarClass2.myVar)
//The fourth difference is that classes can have a deinitializer that gets called when the last reference to an object is destroyed
class MyClassDeInit{
    let var1: Int
    
    init(var1: Int) {
        self.var1 = var1
        print("Var1: \(var1) is ON")
    }
    deinit{
        print("Var1: \(var1) is OFF")
    }
}
for i in 1...5{
    let myClassDeInit = MyClassDeInit(var1: i)
    print("Var1: \(myClassDeInit.var1) I'm here")
}
//The final difference is that classes let us change variable properties even when the class itself is constant
class MyConsClass{
    var var1 = "Manuel"
}
let myConsClass = MyConsClass()
myConsClass.var1 = "Patricia"
print(myConsClass.var1) //Don't need to have mutating keywords in front of methods

//Protocols
protocol MyProtocol{
    var name: String{get}
    var currentPassengers: Int {get set}
    func estimateTime(for distance: Int) -> Int
    func travel(distance: Int)
}
struct MyStructForProtocol: MyProtocol{
    let name = "Manuel"
    var currentPassengers = 1
    func estimateTime(for distance: Int) -> Int {
        distance / 50
    }
    func travel(distance: Int) {
        print("The distance is \(distance)")
    }
    func aditionalFunc(){//The protocol specifies the minimun functionality
        print("This is an aditional function")
    }
}
func conmute(distance: Int, using parameter: MyProtocol){
    if parameter.estimateTime(for: distance) > 100{
        print("Too slow")
    }else{
        parameter.travel(distance: distance)
    }
}
let varProt = MyStructForProtocol()
conmute(distance: 20, using: varProt)

//Extensions
extension String {
    func trimmed() -> String{
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    mutating func trim(){
        self = self.trimmed()
    }
    var lines: [String] {
        self.components(separatedBy: .newlines)
    }
}
var myExtensionString = "      There is an string with spaces     "
myExtensionString.trim()
let myMultipleLineString = """
    This is a
    multiple line
    String
"""
print(myMultpleLineString.lines.count)

//Protocol Extensions
extension Collection{
    var isNotEmpty: Bool{
        isEmpty == false
    }
}
let myArrExten = ["Manuel", "Patricia", "Fatima"]
if myArrExten.isNotEmpty{
    print("The array contains \(myArrExten.count) elements")
}

//Optionals
let opposites = ["Mario": "Wario", "Luiggi": "Waluigi"]
let peachOpposites = opposites["Peach"]
if let marioOpposite = opposites["Mario"] {
    print("Mario's opposite is \(marioOpposite)")
}

//Unwrapping optionals with guard
func myOptionalFunc (number: Int?){
    guard let number = number else{
        print("Missing input")
        return
    }
    print("The number is \(number)")
}
//Nil Coalescing
let myCoalescingArr = ["One", "Two", "Three"]
let myCoalescingArr2 = myCoalescingArr.randomElement() ?? "Unknown"

//Optional chaining
let myOptionalChaining = myCoalescingArr.randomElement()?.uppercased()
print("Next in line: \(myOptionalChaining ?? "Unknown")")

//Optional try?
enum OptionalTryError: Error{
    case badID, networkFailed
}
func optionalTry(id: Int) throws -> String{
    throw OptionalTryError.networkFailed
}
if let optionalUser = try? optionalTry(id: 50){
    print("User is \(optionalUser)")
}
