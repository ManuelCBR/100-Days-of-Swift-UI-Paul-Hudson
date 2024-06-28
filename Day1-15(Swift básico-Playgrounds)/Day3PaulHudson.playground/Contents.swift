import UIKit

//Arrays
let daysWeekArray = ["Monday", "Tuesday", "Wenesday", "Thursday", "Friday", "Saturday", "Sunday"]
let intArray = [1, 3, 5, 7, 9]
let decimalsArray = [1.2, 4.5, 6.5]
print(daysWeekArray[3])

var familyNames = ["Manuel", "Patricia", "Angeles"]
familyNames.append("Carmen") // To add a string
familyNames.append("Fátima")

var qualifications = Array<Double>()
var qualifications2 = [Double]() //Other way to create an Array
qualifications.append(8.7)
qualifications.append(6.5)
qualifications.append(7.8)
print(qualifications[2])

print(daysWeekArray.count) // To count numbers of days
qualifications.remove(at: 1) // To remove one of them
print(familyNames.contains("Manuel")) //To check if the name is in the Array
print(familyNames.sorted()) //To sort the Array
print(familyNames.reversed()) //To reverse the strings

//Dictionaries
let employee = ["name": "Manuel",
                "job": "Programmer",
                "location": "Spain"]
print(employee["job", default: "Unknow"]) //Default is to handle the error in case of de key not exist
let hasGraduated = [
    "Manuel": true,
    "Patricia": true,
    "Francisco": false
]
let olympics = [
    2012: "London",
    2016: "Rio de Janeiro",
    2021: "Tokyo"
]
var weights = [String: Double]()
weights["Patricia"] = 62.7
weights["Manuel"] = 71.1
weights["Manuel"] = 70.1 //This overwrites the value. The Key can't be duplicated

//Sets
var motorbikes = Set(["Honda", "Yamaha", "Suzuki"])
print(motorbikes)
motorbikes.insert("Honda")
motorbikes.insert("Kawasaki") //it's not possible to duplicate any value. The Set remove it automatically
print(motorbikes)

//Enum
enum WeekDay {
    case monday
    case tuesday
    case wenesday
    case thursday
    case friday
    case saturday
    case sunday
}
enum Month {case january, february, march} //Other way to create a Enum
var day = WeekDay.friday
day = .sunday
day = WeekDay.sunday //You can choose a day, and nothing else
