import UIKit

var greeting = "Hello, playground"

import Foundation

struct UserStruct {
    var name: String
}

class UserClass {
    var name: String
    init(name: String) { self.name = name }
}

func measureTime(block: () -> Void) {
    let start = CFAbsoluteTimeGetCurrent()
    block()
    let end = CFAbsoluteTimeGetCurrent()
    print("Execution time: \(end - start) seconds")
}

// Struct Copy Performance
measureTime {
    var users = [UserStruct]()
    //    for i in 0..<1_000_000 {
    for i in 0..<100 {
        users.append(UserStruct(name: "User \(i)"))
    }
}

// Class Reference Performance
measureTime {
    var users = [UserClass]()
    //    for i in 0..<1_000_000 {
    for i in 0..<100 {
        users.append(UserClass(name: "User \(i)"))
    }
}





