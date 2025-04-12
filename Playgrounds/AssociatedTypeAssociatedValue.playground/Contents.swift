import UIKit
import Foundation

var greeting = "Hello, playground"


// 1️⃣ Associated Type (associatedtype in Protocols)

protocol DataManager {
    associatedtype DataType
    associatedtype Address
    
    func create(value: DataType)
    func read(value: DataType, address: Address)
    func update(value: DataType, address: Address)
    func delete(value: DataType, addresss: Address)
}


struct UserStore: DataManager {
    
    typealias DataType = String
    typealias Address = Int
    
    func create(value: String) {
        //
    }
    
    func read(value: String, address: Int) {
        //
    }
    
    func update(value: String, address: Int) {
        //
    }
    
    func delete(value: String, addresss: Int) {
        //
    }
    
}

// 2️⃣ Using Associated Type with Constraints

protocol Repository {
    associatedtype Item: Codable
    func getItem() -> Item
}

struct Book: Codable {
    let title: String
}

struct BookRepository: Repository {
//    func getItem() -> Book {
//        return Book(title: "Peace...")
//    }
    
    func getItem() -> String {
        return "Peace..."
    }
}


// 3️⃣ Associated Values (in Enums)

enum ApiResponse {
    case success(data: String)
    case failure(message: String, errorCode: Int)
}

let response1 = ApiResponse.success(data: "User data loaded")
let response2 = ApiResponse.failure(message: "Not Found", errorCode: 404)

switch response2 {
case .success(let data):
    print("Success \(data)")
case .failure(let message, let errorCode):
    print("Error: \(message) -- \(errorCode)")
}


// Generic Enum

enum APIResult<T> {
    case success(T)
    case failure(message: String, errorCode: Int)
}








