import UIKit

var greeting = "Hello, playground"

print(greeting)


// MARK: - What is protocol oriented programming:
/*
 * By using protocol and protocol extensions we can achieve reusable and flexible code.
 * unlike OOP functionality is inherited from base class, POP allows us to use common behaviour and reuse them across different types (struct, enum and classes). This makes swift more modular and reusable.
 
 * OOP having single inheritance, but POP having multiple protocol composition.
 * OOP only support class, but POP support struct, enum and classes
 * OOP Deep class inheritance causes complexity, POP is modular and easy to extend.
 
 1. Protocol Extensions → Provide default implementations.
 2. Protocol Composition → Combine multiple behaviors dynamically.
 3. Value Types (Structs & Enums) → POP works well with structs, reducing reference-type overhead.
 4. Associated Types → Used in protocols to define generic behavior.
 
 
 */
 

//MARK: - Type 1

/*
protocol Walkable {
    func walk()
}

protocol Flyable {
    func fly()
}

extension Walkable {
    func walk() {
        print("I am walking 🚶")
    }
}

extension Flyable {
    func fly() {
        print("I am flying 🕊️")
    }
}

struct Dog: Walkable {}
struct Bird: Walkable, Flyable {}

let dog = Dog()
dog.walk() // Output: I am walking 🚶

let bird = Bird()
bird.walk() // Output: I am walking 🚶
bird.fly()  // Output: I am flying 🕊️
 */


//MARK: - Protocol Composition in Swift vs. OOP Limitation
// Protocol flow:

/*
 
// Define multiple protocols with specific behaviors
protocol Drivable {
    func drive()
}

protocol Flyable {
    func fly()
}

// Provide default implementations using protocol extensions
extension Drivable {
    func drive() {
        print("🚗 Driving on the road")
    }
}

extension Flyable {
    func fly() {
        print("🛫 Flying in the sky")
    }
}

// Define a type that can do both (Protocol Composition)
struct FlyingCar: Drivable, Flyable {}

// Usage
let vehicle = FlyingCar()
vehicle.drive() // Output: 🚗 Driving on the road
vehicle.fly()   // Output: 🛫 Flying in the sky
 */

//MARK: - Protocol Composition in Swift vs. OOP Limitation
// OOP flow:

class Car {
    func drive() {
        print("🚗 Driving on the road")
    }
}

class Airplane {
    func fly() {
        print("🛫 Flying in the sky")
    }
}

// ❌ Swift does NOT allow multiple inheritance
class FlyingCar: Car, Airplane { } // ERROR: Multiple inheritance not allowed


