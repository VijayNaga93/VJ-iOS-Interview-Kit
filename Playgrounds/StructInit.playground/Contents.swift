import UIKit

var greeting = "Hello, playground"

print(greeting)


struct User {
    
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    init(name: String) {
        self.name = name
        self.age = 33
    }
}

extension User {
    init(age: Int) {
        self.name = "IronMan"
        self.age = age
    }
}

let user1 = User(name: "Vijay")
let user2 = User(name: "Thor", age: 2000)
let user3 = User(age: 50)

print(user1)
print(user2)
print(user3)


