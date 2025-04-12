import UIKit
import Foundation

var greeting = "Hello, playground"

//MARK: - 1️⃣ Generic Function

func swapInt(a: inout Int, b: inout Int) {
    let temp = a
    a = b
    b = temp
}

func swapString(a: inout String, b: inout String) {
    let temp = a
    a = b
    b = temp
}

var aInt = 1
var bInt = 2

var aStr = "V"
var bStr = "J"

swapInt(a: &aInt, b: &bInt)
swapString(a: &aStr, b: &bStr)


print("aInt-->\(aInt) ** bInt-->\(bInt) ** aStr-->\(aStr) ** bStr-->\(bStr)")

 
func swapValue<T>(a: inout T, b: inout T) {
    let temp = a
    a = b
    b = temp
}

swapValue(a: &aInt, b: &bInt)
swapValue(a: &aStr, b: &bStr)

print("aInt-->\(aInt) ** bInt-->\(bInt) ** aStr-->\(aStr) ** bStr-->\(bStr)")


//MARK: - 2️⃣ Generic Classes and Structs


class IntBox {
    var value: Int
    init(value: Int) {
        self.value = value
    }
}

class StringBox {
    var value: String
    init(value: String) {
        self.value = value
    }
}


class Box<T> {
    var value: T
    init(value: T) {
        self.value = value
    }
}

var intBox = Box(value: 100)
var stringBox = Box(value: "Cube")


//MARK: - 3️⃣ Generic Protocols

protocol Container {
    associatedtype T
    func store(value: T)
}

class ContainerString: Container {
    func store(value: String) {
        print(value)
    }
//    typealias T = String
// 
//    func store(value: String) {
//        print(value)
//    }
    
}

//MARK: - 4️⃣ Generic Constraints

func addNumbers<T: Numeric>(a: T, b: T) -> T {
    return a + b
}

addNumbers(a: 5, b: 5)
addNumbers(a: 5.5, b: 2.2)
//addNumbers(a: "V", b: "J")

//MARK: -  5️⃣ Generic Type Extensions

extension Box where T == Int {
    func doubleValue() -> T {
       return value * 2
    }
}

let intBox2 = Box(value: 5)
intBox2.doubleValue()

//MARK: - 7️⃣ Generic Enums

enum Result<T> {
    case success(T)
    case failure(String)
}

let successResponse1 = Result.success("Load Data")
let failureResponse1 = Result<Int>.failure("Bad Request")

//switch successResponse1 {
//case .success(let data):
//    //
//case .failure(let error):
//    //
//}


//MARK: - 🔹 Generic Function Overloading Example

func genericOverloadCheck(value: Int) {
    
}

func genericOverloadCheck<T>(value: T) {
    
}

//func genericOverloadCheck<T>(value: T) -> T {
//    
//}

func genericOverloadCheck<T : Numeric>(value: T) {
    
}

//MARK: - 🔹 Generic Function Overloading by Return Type

func getDefaultValue<T>() ->T where T: ExpressibleByIntegerLiteral {
    return 1 as! T
}

let intValue: Int = getDefaultValue()



