import UIKit

var greeting = "Hello, playground"


//MARK: - Override

class Animal {
    var age: Int?
    var lifeSpan: Int { return 0 }
    
    func makeSound() {
        print("Animals make sound")
    }
}

class Dog: Animal {

    override var lifeSpan: Int { return 15 } // Overriding Properties
    
    override func makeSound() { // Overriding method
        print("Dog barks!")
        

    }
}


//MARK: - Overload

class MathOperations {
    func add(a: Int, b: Int) -> Int {
        return a + b
    }

    func add(a: Double, b: Double) -> Double {
        return a + b
    }

    func add(a: Int, b: Int, c: Int) -> Int {
        return a + b + c
    }
}

let math = MathOperations()
print(math.add(a: 5, b: 3))       // Output: 8
print(math.add(a: 5.5, b: 2.3))   // Output: 7.8
print(math.add(a: 1, b: 2, c: 3)) // Output: 6

// 4️⃣ Overloading Initializers (Constructors)

class Person {
    var name: String
    var age: Int?

    init(name: String) {
        self.name = name
    }

    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

let p1 = Person(name: "Alice")
let p2 = Person(name: "Bob", age: 30)






