import UIKit

//For Loop
let names = ["Manuel", "Patricia", "Fatima", "Pablo", "Carmen"]
for employee in names {
    print("Employee: \(employee)")
}
for name in names { //Swift can recognize that name is the singular of names, and it add the for loop
    print("Employee: \(name)")
}
for i in 1...5 {
    print("This is the iteration \(i)")
}
for i in 1..<5 {
    print("From 1 to 4: \(i)")
}

//While Loop
var counter = 20
while counter > 0{
    print(counter)
    counter -= 1
}

let id = Int.random(in: 1...1000)
let amount = Double.random(in: 0...1)

var roll = 0

while roll != 20 {
    roll = Int.random(in: 1...20)
    print("I rolled a \(roll)")
}

for i in 1...100{
    print(i)
    if i == 45 {break} //To stop a loop with a condition
}

//CheckPoint 3 (FizzBuzz)

for i in 1...100{
     
    if (i.isMultiple(of: 3) && i.isMultiple(of: 5)){
        print("FizzBuzz")
    }else if i.isMultiple(of: 3){
        print("Fizz")
    }else if (i.isMultiple(of: 5)){
        print("Buzz")
    }else{
        print(i)
    }
}

