import UIKit

var greeting = "Hello, playground"

//MARK: - Type1
//class Person {
//    let name: String
//
//    init(name: String) {
//        self.name = name
//        print("\(name) is initialized")
//    }
//
//    deinit {
//        print("\(name) is deallocated")
//    }
//}
//
//var person1: Person? = Person(name: "Thor")
//var person2: Person? = person1
//
//
//person2 = nil
//person1 = nil


//MARK: - Type2
//class Person {
//    var name: String
//   weak var friend: Person?
//    
//    init(name: String, friend: Person? = nil) {
//        self.name = name
//        self.friend = friend
//        print("\(name) is initialized")
//    }
//    deinit {
//        print("\(name) deallocated")
//    }
//}
//
//var person1: Person? = Person(name: "P1")
//var person2: Person? = Person(name: "P2")
//person1?.friend = person2
//person2?.friend = person1
//
////person1?.friend = nil
////person1 = nil
////person2?.friend = nil
////person2 = nil

//MARK: - Type3

//class Friend {
//    var name: String
//    var person: Person?
//    init(name: String, person: Person? = nil) {
//        self.name = name
//        self.person = person
//        print("\(name) is initialized")
//    }
//    
//    deinit {
//        print("\(name) deallocated")
//    }
//}
//
//class Person {
//    var name: String
//    weak var friend: Friend?
//    
//    init(name: String, friend: Friend?) {
//        self.name = name
//        self.friend = friend
//        print("\(name) is initialized")
//    }
//    
//    deinit {
//        print("\(name) deallocated")
//    }
//}
//
////var person1 = Person(name: "P1", friend: Person(name: "P2", friend: Person(name: "P3", friend: <#T##Person#>)))
//
////var person2: Person? = Person(name: "P1", friend: Friend(name: "F1"))
////person2 = nil
//
//var person3: Person? = Person(name: "P1", friend: nil)
//var friend1: Friend? = Friend(name: "F1")
//
//
//person3?.friend = friend1
//friend1?.person = person3
//
//person3 = nil
//friend1 = nil



/*
 P3 - 1
 P4 - 1
 F1 - 1 + 1
 F2 - 1 + 1
 
 Weak P3.F = F1
 Weak P4.F = F2
 */


//MARK: - Type4

//class Person {
//    let name: String
//
//    init(name: String) {
//        self.name = name
//        print("\(name) is initialized")
//    }
//
//    deinit {
//        print("\(name) is deallocated")
//    }
//}
//
//var person1: Person? = Person(name: "Thor")
//var person2: Person? = person1
//
//
//person2 = nil
//person1 = nil





//MARK: - Reference count check with weak assign


class Person {
    let name: String
    
    init(name: String) {
        self.name = name
        print("\(name) is initialized")
    }
    
    deinit {
        print("\(name) is deallocated")
    }
}

var person1: Person? = Person(name: "Alice")  // ARC count Person = 1
var person2: Person? = person1 // ARC count Person + 1 = 2
var person3: Person? = person2 // ARC count ?
weak var person4: Person? = person3 // ARC count ?
weak var person5: Person? = person4 // ARC count ?
var person6: Person? = person5 // ARC count ?
var person7: Person? = person6 // ARC count ?



person1 = nil
person2 = nil
person3 = nil
//person4 = nil
//person5 = nil
person6 = nil
person7 = nil






