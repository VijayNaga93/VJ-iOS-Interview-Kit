//
//  UsersWebService.swift
//  PhotoAppUnitTesting
//
//  Created by NAGARAJAN, VIJAY (V.) on 12/11/24.
//

import Foundation

class UsersWebService {
    
    private var urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func fetchUsers(urlString: String, completionHandler: @escaping ([UserModel]?, Error?) -> Void) {
        guard let url = URL(string: urlString) else {
            // TODO: Create a unit test to test that a specific error message is returned is URL is nil
            completionHandler(nil, SignupError.invalidRequestURLString)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let dataTask = urlSession.dataTask(with: request) { data, response, error in
            
            if let requestError = error {
                completionHandler(nil, requestError)
                return
            }
            
            if let data = data {
                do {
                    let userModel = try self.dataToUserModelConvertor(responseData: data)
                    completionHandler(userModel, nil)
                } catch {
                    completionHandler(nil, error)
                }
            }
            
        }
        dataTask.resume()
    }
    
    func dataToUserModelConvertor(responseData: Data) throws -> [UserModel] {
        try JSONDecoder().decode([UserModel].self, from: responseData)
    }
    
}
