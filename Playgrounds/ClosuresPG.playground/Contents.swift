import UIKit


var greeting = "Hello, playground"


//MARK: - Type 1
class CheckButton {
    var action: (() -> Void)?
    
    func tap() {
        action?()
    }
}

let checkButtonInstance = CheckButton()
checkButtonInstance.action = {
    print("tap action triggered")
}
checkButtonInstance.tap()


//MARK: - Type 2

// Global Closures
func greet() -> String {
    return "Hello, World!"
}

print(greet())  // Output: "Hello, World!"

// Nested Closures

func outerClosure(value: Int) {
    var finalValue : Int = 0
    let innerClosure1 = {
        print("Inner closure 1 triggered")
        finalValue = 11
    }
    let innerClosure2 = {
        print("Inner closure 2 triggered")
        finalValue = 22
    }
    
    if value == 1 {
        innerClosure1()
    } else {
        innerClosure2()
    }
    print("Nested Closures--> finalValue : \(finalValue)")
}

outerClosure(value: 2)

// 3️⃣ Closure Expressions (Anonymous Functions)
//Closures without a name that can be assigned to variables.

let sum: (Int, Int) -> Int = { (a, b) in
    return a + b
}

print(sum(5, 3))  // Output: 8

// 4️⃣ Trailing Closures



func performTask(completion: () -> Void) {
    print("Task started")
    completion()
}

// Using trailing closure syntax
performTask {
    print("Task completed")
}


func performTask1(name: String, age: Int, compeltion: () -> Void, company: String) {
    print("\(name) -- \(age)")
}



// Output:
// Task started
// Task completed

// 5️⃣ Auto-Closure (@autoclosure)

func checkIfTrue1(_ condition: @autoclosure () -> Void, _ message: @autoclosure () -> Void) {
    condition()
//    message()
}

checkIfTrue1({
    print("checkIfTrue1 -- condition")
}(), {
    print("checkIfTrue1 -- message")
}())

func checkIfTrue2(_ condition: @autoclosure (()-> Bool), _ message: @autoclosure (()-> String)) {
    if condition() {
        print(message())
    }
}
checkIfTrue2(1 < 2, "Yes true")

// 6️⃣ Escaping Closures (@escaping)

var storedClosure: (() -> Void)?

@MainActor func saveClosure(closure: @escaping (() -> Void)) {
    storedClosure = closure
}

saveClosure {
    print("This closure execute later!")
}

storedClosure?()



//7️⃣ Capturing Closures (Strong, Weak, and Unowned)
class Person {
    var name: String
    
    init(name: String) {
        self.name = name
        print("Capturing Closures Person \(name) initialized")
    }
    
    func sayHello() {
        let closure = {
            print("Hello, \(self.name)")
        }
        
//        let closure = { [weak self] in
//            print("Hello, \(self?.name)")
//        }
        
        closure()
    }
    
    deinit {
        print("Capturing Closures Person \(name) deallocated")
    }
}

var person: Person? = Person(name: "Thor")

person?.sayHello()  // Output: "Hello, John"
person = nil



// 8️⃣ Completion Handlers (Closures for Async Operations)

func fetchData(completionHandler: @escaping (String) -> Void) {
    
        DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
//    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//        completionHandler("delayed handler for 3 seconds")
        completionHandler("delayed handler for 3 seconds")
    }
}

fetchData { value in
    print(value)
}





