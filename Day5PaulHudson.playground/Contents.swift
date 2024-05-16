import UIKit

//Conditions
//If Else if
let age = 19
let working = true
if age >= 18 && working == false{
    print("You are an adult")
}else if age >= 18 && working == true {
    print("You are an adult and you are working")
}else{
    print("You are a child")
}

enum Animals {
    case Lion, Dolphin, Cheetah, Tiger, Whale
}
let animal = Animals.Cheetah

if (animal == .Dolphin || animal == .Whale){
    print("They can swim!")
} else if (animal == .Lion || animal == .Tiger){
    print("They can run fast on the surface")
} else {print("He is a Cheetah! He can run fast on the surface and also is the faster than all of them")}

//Switch
enum Weather {
    case sun, rain, wind, snow, unknow
}
var forecast = Weather.rain

switch forecast {
    case .rain:
        print("Take an umbrella")
    case .sun:
        print("It should be a nice day")
    case .wind:
        print("you are gonna fly")
    case .snow:
        print("To ski!")
    case .unknow:
        print("Our forecast generator is broken!")
}

let superHero = "BlackPanther"

switch superHero {
    case "BlackPanther":
        print("You are from Wakanda")
    case "Batman":
        print("You are from Gotham City")
    case "Super Man":
        print("You are from Kripton")
    default: print("Are you a Super Hero")
}

//Ternary conditional operator
let age2 = 18
let isAdult = age2 >= 18 ? "Yes" : "No" // W (What) T (True) F (False)
print(isAdult)
