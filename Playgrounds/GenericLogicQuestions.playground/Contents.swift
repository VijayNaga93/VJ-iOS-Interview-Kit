import UIKit


var greeting = "Hello, playground"

//MARK: -  🔹 Add question:
// Write a generic method to add a + b (input: a:1, b:2 and a: “hello”, b: world)

class Addition {

    func add<T: Numeric>(a: T, b: T) -> T {
        return a + b
    }
    
    func add(a:String, b: String) -> String {
        return a + b
    }
}

let addition1 = Addition().add(a: 1, b: 2)
let addition2 = Addition().add(a: "1", b: "2")
let addition3 = Addition().add(a: 1.3, b: 2.2)


//protocol Addable {
//   static func +(val1: Self, val2: Self) -> Self
//    static func -(val1: Self, val2: Self) -> Self
//}



protocol Addable {
   static func +(val1: Self, val2: Self) -> Self
}


protocol Subtractable {
    static func -(val1: Self, val2: Self) -> Self
}

extension Int: Addable { }
extension Int: Subtractable { }


func addd<T: Addable>(a: T, b: T, c: T) -> T {
    return a + b
}

func subb<T: Subtractable>(a: T, b: T) -> T {
    return a - b
}

func addd1<T: Addable>(a: String, b: T, c: T) -> T {
    return b + c
}


print(addd(a: 1, b: 2, c: 2))
print(subb(a: 1, b: 2))
print(addd1(a: "ABC", b: 1, c: 2))




//MARK: -  Behind the + scene

let sum1 = 5 + 3
let sum2 = (5).addingReportingOverflow(3)
print("\(sum1) --- \(sum2.partialValue)")








