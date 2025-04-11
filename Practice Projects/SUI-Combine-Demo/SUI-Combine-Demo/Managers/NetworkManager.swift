//
//  NetworkManager.swift
//  SUI-Combine-Demo
//
//  Created by NAGARAJAN, VIJAY (V.) on 2/24/25.
//

/*
 
 import Foundation
 import Combine
 
 class UserApiWorker: NetworkManager {
 
 }
 
 class NetworkManager {
 static var shared = NetworkManager()
 
 var cancellables = Set<AnyCancellable>()
 
 func fetchUserApi(completionHandler: @escaping ((Result<[UserModel], Error>) -> Void)) {
 
 guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
 completionHandler(.failure(PDNetworkError.badURL))
 return
 }
 
 //        let userPublisher = URLSession.shared.dataTaskPublisher(for: url)
 URLSession.shared.dataTaskPublisher(for: url)
 .receive(on: DispatchQueue.main)
 .map(\.data)
 .decode(type: [UserModel].self, decoder: JSONDecoder())
 .eraseToAnyPublisher()
 .sink { completion in
 switch completion {
 case .finished:
 print("Api fetch finished")
 case .failure(let err):
 print(err.localizedDescription)
 completionHandler(.failure(err))
 }
 } receiveValue: { userModel in
 completionHandler(.success(userModel))
 }
 .store(in: &cancellables)
 
 
 }
 
 func fetchPostApiCheck(completionHandler: @escaping ((Result<[UserModel], Error>) -> Void)) {
 
 guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
 completionHandler(.failure(PDNetworkError.badURL))
 return
 }
 
 var headerParam: [String:String] = [:]
 var bodyParam: [String:Any] = [:]
 
 let urlRequest = createRequest(url: url, method: "GET", headers: headerParam, postParamDict: bodyParam)
 
 URLSession.shared.dataTaskPublisher(for: urlRequest)
 .receive(on: DispatchQueue.main)
 .map(\.data)
 .decode(type: [UserModel].self, decoder: JSONDecoder())
 .eraseToAnyPublisher()
 .sink { completion in
 switch completion {
 case .finished:
 print("Api fetch finished")
 case .failure(let err):
 print(err.localizedDescription)
 completionHandler(.failure(err))
 }
 } receiveValue: { userModel in
 completionHandler(.success(userModel))
 }
 .store(in: &cancellables)
 
 
 }
 
 
 func createRequest(url: URL, method: String, headers: [String: String], postParamDict: [String: Any]?) -> URLRequest {
 var request = URLRequest(url: url)
 request.httpMethod = method
 
 request.setValue("application/json", forHTTPHeaderField: "Content-Type")
 request.setValue("Bearer your_token_here", forHTTPHeaderField: "Authorization")
 
 headers.forEach { request.setValue($1, forHTTPHeaderField: $0) }
 
 if let postParam = postParamDict {
 let postParamData = try? JSONSerialization.data(withJSONObject: postParam, options: [])
 request.httpBody = postParamData
 }
 
 return request
 }
 }
 */



import Foundation
import Combine

class UserApiWorker: NetworkManager {
    
    static var shared = UserApiWorker()
    
    var cancellables = Set<AnyCancellable>()
    
    func fetchUserApi(completionHandler: @escaping ((Result<[UserModel], Error>) -> Void)) {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            completionHandler(.failure(CustomProjError.badURL))
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .map(\.data)
            .decode(type: [UserModel].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
            .sink { completion in
                switch completion {
                case .finished:
                    print("Api fetch finished")
                case .failure(let err):
                    print(err.localizedDescription)
                    completionHandler(.failure(err))
                }
            } receiveValue: { userModel in
                completionHandler(.success(userModel))
            }
            .store(in: &cancellables)
        
        
    }
    
    func fetchPostApiCheck(completionHandler: @escaping ((Result<[UserModel], Error>) -> Void)) {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            completionHandler(.failure(CustomProjError.badURL))
            return
        }
        
        var headerParam: [String:String] = [:]
        var bodyParam: [String:Any] = [:]
        
        let urlRequest = createRequest(url: url, method: "GET", headers: headerParam, postParamDict: bodyParam)
        
        URLSession.shared.dataTaskPublisher(for: urlRequest)
            .receive(on: DispatchQueue.main)
            .map(\.data)
            .decode(type: [UserModel].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
            .sink { completion in
                switch completion {
                case .finished:
                    print("Api fetch finished")
                case .failure(let err):
                    print(err.localizedDescription)
                    completionHandler(.failure(err))
                }
            } receiveValue: { userModel in
                completionHandler(.success(userModel))
            }
            .store(in: &cancellables)
        
        
    }
    
}

class NetworkManager {
    
    func createRequest(url: URL, method: String, headers: [String: String], postParamDict: [String: Any]?) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer your_token_here", forHTTPHeaderField: "Authorization")
        
        headers.forEach { request.setValue($1, forHTTPHeaderField: $0) }
        
        if let postParam = postParamDict {
            let postParamData = try? JSONSerialization.data(withJSONObject: postParam, options: [])
            request.httpBody = postParamData
        }
        
        return request
    }
}
