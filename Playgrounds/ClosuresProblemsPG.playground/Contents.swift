import UIKit


var greeting = "Hello, playground"


//MARK: - Problem 1
//Capture List
func problem1() {
    var fruit1: String = "Apple"
    var closure1 = {
        print("The friut1 name is \(fruit1)")
    }
    fruit1 = "Grapes"
    closure1()
}
problem1()

//MARK: - Problem 2
func problem2() {
    var fruit2: String = "Apple"
    var closure2 = { [fruit2] in
        print("The fruit2 name is \(fruit2)")
    }
    fruit2 = "Grapes"
    closure2()
}
problem2()

//MARK: - Problem 3
func problem3() {
    var fruit3: String = "Apple"
    var fruit3Count: Int = 50
    
    var closure3 = { [fruit3, count = fruit3Count] in
        print("The fruit3 name is \(fruit3) and \(count) count...")
    }
    fruit3 = "Grapes"
    fruit3Count = 100
    closure3()
}
problem3()


//MARK: - Problem 4 - Capture List and Memory Leak

func problem4() {
    
    class User {
        var name = "John"
        

        /*
         
// Computed property closure
        var printName: () -> Void {
            return {
                print("Name is \(self.name)")
            }
        }
   
         // Stored property clousre
        var printName: () -> Void = {
            return {
                print("Name is \(self.name)")
            }
        }
        
         // Immediately executed closure
        var printName: () -> Void = {
            return {
                print("Name is \(self.name)")
            }
        }()
         
         */
        
        // lazy
        lazy var printName: () -> Void = { [weak self] in
            print("Name is \(self?.name ?? "Empty Name")")
        }
        
        deinit {
            print("User deinitialized")
        }
        
    }
    
    var user: User? = User()
    user?.printName()
    user = nil
}

problem4()

//MARK: - Problem 4 - Sorting with Closure - Q: Sort an array of strings by their length in descending order using closure.


class SortingWithClosure {
    let names = ["John", "Alexandra", "Amy", "Bob"]

    func closureSort(arr: [String], sortType: (() -> ())) -> [String] {
        arr.sorted(by: {$0 > $01})
        return arr.sorted(by: {(value1: String, value2: String) -> Bool in
            return value1 > value2
        })
    }
}


//MARK: - Problem 4 - Custom Map Using Closure - Q: Implement your own myMap method using closure.

class CustomMapUsingClosure {
    
    func customMapCheck() {
        let numbers = [1, 2, 3, 4, 5]
        let temp1 = numbers.map { val in
            return val * 2
        }
        let temp2 = numbers.map({ $0 * 3})
        let temp3 = numbers.myMap({ $0 * 4})
        
        print("temp1-->\(temp1)")
        print("temp2-->\(temp2)")
        print("temp3-->\(temp3)")
//        @inlinable public func map<T, E>(_ transform: (Element) throws(E) -> T) throws(E) -> [T] where E : Error
        
        
    }
}

extension Array {
     func myMap<T>(_ transform: (Element) -> T) -> [T] {
         var mappedArr: [T] = []
         
         for val in self {
             mappedArr.append(transform(val))
         }
         return mappedArr
    }
}

CustomMapUsingClosure().customMapCheck()


//MARK: - Problem 5 - Closure as Completion Handler - Q: Implement a function that simulates a network call using a closure for completion.

enum CustomError: Error {
    case apiError
}

class ClosureAsCompletionHandler {
    func fetchUser(_ completionHandler: @escaping (Result<String, Error>) -> Void) {
        if 1 == 1 {
            completionHandler(.success("username"))
        } else {
            completionHandler(.failure(CustomError.apiError))
        }
    }
    
    func checkFetchUserCall() {
        fetchUser { resultObj in
            switch resultObj {
            case .success(let user):
                print(user)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}


//MARK: - Problem 6 - Chained Closures - Q: Chain two closures where the second runs after the first finishes.

class ChainedClosures {
    func run(first: @escaping (()->Void) -> Void, then second: () -> Void) {
        // implement chaining logic
        if 1 == 1 {
            first({
                second()
            })
        }
    }
    func check() {
        run { innerClosure in
            innerClosure()
        } then: {
            
        }
    }
}


//MARK: - Problem 7 - Closure in struct vs class

struct ClosureStruct {
    var didSelect: ((String)->Void)? = nil
    
    func buttonTap() {
        didSelect?("Tapped")
    }
    
    var name: String = "Alice"
    
    var printName: () -> Void {
        return {
            print("Name is \(self.name)")
        }
    }
    

}

class ClosureClass {
    var didSelect: ((String)->Void)? = nil
    
    func buttonTap() {
        didSelect?("Tapped")
    }
    
    var name: String = "Alice"
    
    lazy var printName: () -> Void = { [weak self] in
        print("Name is \(self?.name ?? "nil")")
    }
}

class CheckStructClassClosure {
    
   class func csCheck() {
        var cs = ClosureStruct()
        cs.didSelect = { str in
            str
        }
        cs.printName()
        cs.name = "Thor"
        cs.printName()
    }
    
    class func ccCheck() {
        let cc = ClosureClass()
        cc.didSelect = { str in
            str
        }
        
        cc.printName()
        cc.name = "Thor"
        cc.printName()
    }
    
}

CheckStructClassClosure.ccCheck()




/*
 
 func dispatchProblem1() {
 print("1")
 
 DispatchQueue.main.async {
 print("2")
 }
 
 print("3")
 
 DispatchQueue.global().sync {
 print("4")
 }
 
 print("5")
 }
 
 
 //dispatchProblem1()
 
 
 func dispatchProblem2() {
 print("1")
 
 DispatchQueue.main.async {
 print("2")
 }
 
 print("3")
 
 DispatchQueue.global().sync {
 print("4")
 }
 
 print("5")
 
 DispatchQueue(label: "test1", attributes: .concurrent).async {
 print("6")
 }
 
 print("7")
 
 DispatchQueue(label: "test2").async {
 print("8")
 }
 
 print("9")
 
 }
 
 dispatchProblem2()
 
 /*
  1  1
  3  3
  4  4
  5  5
  7  7
  9  6
  2  9
  6  8
  8  2
  */
 
 */
