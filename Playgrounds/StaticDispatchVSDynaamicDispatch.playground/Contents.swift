import UIKit

var greeting = "Hello, playground"

//MARK: - Static Dispatch

struct Thanos {
    func sayInevitable() {
        print("I am Inevitable...")
    }
}

let thanos = Thanos()
thanos.sayInevitable() // Directly calls the function


//MARK: - Dynamic Dispatch

class IronManSuit {
    func suitUp() {
        print("Mechanical sound... suiting up...")
    }
}

class Mark1Suit: IronManSuit {
    override func suitUp() {
        print("High Mechanical sound... suiting up...")
    }
}

let ironManSuit1 = Mark1Suit()
ironManSuit1.suitUp()

//protocol HeroSpecification {
//    var color: UIColor? { get }
//}

class Hulk {
    var color: UIColor? = nil
    var powerLevel: Int = 0
    
    init(color: UIColor? = nil, powerLevel: Int) {
        self.color = color
        self.powerLevel = powerLevel
    }
    
     func suitUp() {
        print("I am always angry.. Grrr.")
    }
}

class RedHulk: Hulk {
    var character: String
    
    init(character: String, color: UIColor) {
        self.character = character
//        super.init()
//        super.color = .red
//        super.powerLevel = 5
        super.init(color: color, powerLevel: 5)
    }
    
}

let redHulk = RedHulk(character: "President", color: .red)
print("\(redHulk.suitUp()) -- \(redHulk.color?.description) -- \(redHulk.powerLevel)")



//MARK: - Type 1

protocol ExampleProtocol1 {
 func check1()
}

@objc protocol ExampleProtocol2 {
    @objc optional func check1()
    func check2()
}

@objc protocol ExampleProtocol3 {
    func check1()
}

//

class ExampleClass1: ExampleProtocol1 {
    func check1() {
        
    }
}

class ExampleClass2: ExampleProtocol2 {
    func check2() {
        
    }
}

class ExampleClass3: ExampleProtocol3 {
    func check1() {
        
    }
}

//

struct ExampleStruct1: ExampleProtocol1 {
    func check1() {
        
    }
}

//struct ExampleStruct2: ExampleProtocol3 {
//    
//}


