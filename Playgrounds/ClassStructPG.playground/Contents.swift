import UIKit

var greeting = "Hello, playground"

class Car {
    var brand: String
    
    init(brand: String) {
        self.brand = brand
    }
}

var car1 = Car(brand: "Tesla")
var car2 = car1
car2.brand = "BMW"
car1.brand

let car3 = Car(brand: "Audi")
car3.brand = "Tata"


struct Bus {
    var brand: String
    
    init(brand: String) {
        self.brand = brand
    }
}

var bus1 = Bus(brand: "Tesla")
var bus2 = bus1
bus2.brand = "BMW"
bus1.brand

//let bus3 = Bus(brand: "Audi")
//bus3.brand = "Tata"

//MARK: - Inheritance Check
// Class check
//class Weapon {
//    var powerLevel : Int
//    init(powerLevel: Int) {
//        self.powerLevel = powerLevel
//    }
//    
//    func powerLevelCheck() {
//        print("Power level of this weapon is \(powerLevel)")
//    }
//}
//
//class Sword: Weapon {
//    var range: Int
//    
//    init(range: Int, powerLevel: Int) {
//        self.range = range
//        super.init(powerLevel: powerLevel)
//    }
//}
//
//let sword1 = Sword(range: 2, powerLevel: 3)
//sword1.powerLevelCheck()

// Struct check


protocol WeaponProtocol {
    var powerLevel1: Int { get }
    var powerLevel2: Int { get set }
    var range1: Int? { get }
    var range2: Int? { get set }
    
    func checkWeaponDescription()
}

extension WeaponProtocol {
    func weaponDefaultDescription(weaponType: String) -> String {
        return "This \(weaponType) has \(powerLevel1) power."
    }
}

struct Weapon {
    var powerLevel: Int
    
    init(powerLevel: Int) {
        self.powerLevel = powerLevel
    }
}

struct SwordS: WeaponProtocol {
    var powerLevel1: Int
    var powerLevel2: Int
    let range1: Int?
    var range2: Int?
    
    func checkWeaponDescription() {
        
    }
}

class SwordC: WeaponProtocol {
    var powerLevel1: Int
    var powerLevel2: Int
    let range1: Int?
    var range2: Int?
    
    init(powerLevel1: Int, powerLevel2: Int, range1: Int? = nil, range2: Int? = nil) {
        self.powerLevel1 = powerLevel1
        self.powerLevel2 = powerLevel2
        self.range1 = range1
        self.range2 = range2
    }
    
    func checkWeaponDescription() {
        
    }
}

var swordS1 = SwordS(powerLevel1: 1, powerLevel2: 1, range1: nil)
let swordS2 = SwordS(powerLevel1: 2, powerLevel2: 2, range1: 2, range2: 2)

swordS1.powerLevel1 = 11
swordS1.powerLevel2 = 11
//swordS1.range1 = 11
swordS1.range2 = 11
let thorHammerDesc = swordS1.weaponDefaultDescription(weaponType: "Thor Hammer")
print(thorHammerDesc)
//swordS2.powerLevel1 = 22




var swordC1 = SwordC(powerLevel1: 1, powerLevel2: 1)
let swordC2 = SwordC(powerLevel1: 2, powerLevel2: 2, range1: 2, range2: 2)

swordC1.powerLevel1 = 11
swordC1.powerLevel2 = 11
//swordC1.range1 = 11
swordC1.range2 = 11
let capShieldDesc = swordC1.weaponDefaultDescription(weaponType: "Captain Shield")
print(capShieldDesc)
swordC2.powerLevel1 = 22









