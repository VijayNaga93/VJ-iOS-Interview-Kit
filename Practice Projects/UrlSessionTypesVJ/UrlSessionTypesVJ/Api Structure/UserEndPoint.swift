//
//  UserEndPoint.swift
//  UrlSessionTypesVJ
//
//  Created by Vijay N on 02/04/25.
//

import Foundation

enum UserEndPoint: EndPointProtocol {
    
    case getUsers
    case getUserById(id: Int)
    case createUser(name: String, email: String)
    
    var baseURL: String { return "" }
    
    
    var path: String {
        switch self {
        case .getUsers:
            return "https://jsonplaceholder.typicode.com/users"
        case .getUserById(id: let id):
            return "iii"
        case .createUser(name: let name, email: let email):
            return "jjj"
        }
    }
    
    var method: String {
        switch self {
        case .getUsers:
            return "GET"
        case .getUserById(let id):
            return "GET"
        case .createUser(let name, let email):
            return "GET"
        }
    }
    
    var body: Data? {
        
        var param: [String: Any] = [:]
        
        switch self {
        case .createUser(let name, let email):
            param = ["name": name, "email": email]
        default:
            return nil
        }
        return try? JSONSerialization.data(withJSONObject: param, options: .prettyPrinted)
    }
    
    var headers: [String : String] {
        ["Content-Type": "application/json"]
    }
    
    
    
    func request() -> URLRequest {
        let url = URL(string: baseURL + path)!
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.httpBody = body
        for val in headers {
//            request.addValue(val.value, forHTTPHeaderField: val.key)
            request.setValue(val.value, forHTTPHeaderField: val.key)
        }
        
        return request
    }
    
}
