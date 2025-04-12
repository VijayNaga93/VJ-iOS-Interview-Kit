import UIKit
import Foundation


var greeting = "Hello, playground"

let laptop = ("MacBook", 555)
let point = (x: 10, y: 20)

//MARK: -  Empty typle
let emptyTuple = ()


//MARK: -  Unnamed tuple
let coordinates = (55.789, 77.543)

let person = ("Thor", 2000)
print("\(person.0) age is \(person.1)")


//MARK: -  Named tupes

let coordinates1 = (lat: 55.123, lon: 22.345)
coordinates1.lat
coordinates1.lon

let userInfo1 = ("Thor", 2000, ("King of Asguard", "God", 3))
userInfo1.0
userInfo1.1
userInfo1.2.0

//MARK: -  Typealias tuple

typealias StudentTuple = (String, Int)
func studentDetail(name: String, age: Int) -> StudentTuple {
    return studentDetail(name: name, age: age)
}
let harryPotter = studentDetail(name: "Harry potter", age: 13)
harryPotter.0
harryPotter.1

//MARK: -  Tuple for Returned Function Values

func getPersonDetail()  -> (String, Int, String) {
    return ("Mike", 45, "New York USA, 10001")
}

//MARK: - Multiple assignment

var (nameMA, ageMA, subjectMA) = ("student1", 10, "Maths")
nameMA
ageMA
subjectMA

//MARK: - Add remove elements from tuple

var student2 = ("Student2", 13, "Maths")
print(student2.0)
student2.0 = "Student222"
print(student2.0)

//MARK: -  Decomposing tuples

let response = (code: 502, message: "Bad Gateway")
let (responseCode, responseMessage) = response
print("\(responseCode) -- \(responseMessage)")



