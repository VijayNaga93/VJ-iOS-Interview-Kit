import UIKit

var greeting = "Hello, playground"

//MARK: - 1️⃣ Tightly Coupled Code Example

class DatabaseManager1 {
    func fetchData() {
        print("Fetching data from database...")
    }
}

class UserManager1 {
    let dbManager = DatabaseManager1()  // Direct dependency
    
    func getUserData() {
        dbManager.fetchData()
    }
}

let userManager1 = UserManager1()
userManager1.getUserData()  // Output: Fetching data from database...




//MARK: - 2️⃣ Decoupled Code Example (Using Dependency Injection & Protocols)

protocol DataService {
    func fetchData()
}

class DatabaseManager: DataService {
    func fetchData() {
        print("Fetching data from database...")
    }
}

class APIManager: DataService {
    func fetchData() {
        print("Fetching data from API...")
    }
}

class UserManager {
    let dataService: DataService  // Depend on abstraction, not concrete class
    
    init(dataService: DataService) {
        self.dataService = dataService
    }
    
    func getUserData() {
        dataService.fetchData()
    }
}

// Injecting dependency
let dbUserManager = UserManager(dataService: DatabaseManager())
dbUserManager.getUserData()  // Output: Fetching data from database...

let apiUserManager = UserManager(dataService: APIManager())
apiUserManager.getUserData()  // Output: Fetching data from API...
