import UIKit

var greeting = "Hello, playground"

print(greeting)


// 1️⃣ Open (Most Permissive)

open class OpenClass {
    open func greet() {
        print("Hello from OpenClass!")
    }
}

class SubClass1: OpenClass {
    override func greet() {
        print("Subclass Override")
    }
}


// 2️⃣ Public

public class PublicClass {
    public func greet() {
        print("Hello from PublicClass!")
    }
}

class SubClass2: PublicClass {
    // ❌ Cannot override greet() because it's only public, not open.
}


// 3️⃣ Internal (Default)

internal class InternalClass {
    internal func greet() {
        print("Hello from InternalClass!")
    }
}

// 4️⃣ Fileprivate

class FilePrivateExample {
    fileprivate func greet() {
        print("Hello from FilePrivate!")
    }
}

let obj1 = FilePrivateExample()
obj1.greet() // ✅ Allowed (same file)


//5️⃣ Private (Most Restrictive)

class PrivateExample {
    private var message = "Hello, Private World!"
    
    private func greet() {
        print(message)
    }
}

let obj2 = PrivateExample()
// ❌ obj.greet() // ERROR: Cannot access 'greet' outside the class


//final in Swift
//The final keyword is not an access specifier, but it is used to prevent inheritance, method overriding, and property overriding in Swift.

//1️⃣ final with Classes (Prevents Inheritance)

final class Animal1 {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

// ❌ ERROR: Cannot inherit from a final class
class Dog1: Animal1 {}



//2️⃣ final with Methods (Prevents Overriding)

class Animal2 {
    final func makeSound() {
        print("Some generic animal sound")
    }
}

class Dog2: Animal2 {
    // ❌ ERROR: Cannot override a final method
    override func makeSound() {
        print("Bark!")
    }
}

//3️⃣ final with Properties (Prevents Overriding)

class Animal3 {
    final var species = "Mammal"
}

class Dog3: Animal3 {
    // ❌ ERROR: Cannot override final property
    override var species: String {
        return "Canine"
    }
}


// static vs class

class Animal {
    static func makeSound() { print("Some sound") }
    class func speak() { print("Animal speaks") }
}

class Dog: Animal {
    // ❌ Cannot override static method
    override class func speak() {
        print("Dog barks")
    }
}

Dog.speak()  // ✅ "Dog barks"
Animal.makeSound() // ✅ "Some sound"
Dog.makeSound()

