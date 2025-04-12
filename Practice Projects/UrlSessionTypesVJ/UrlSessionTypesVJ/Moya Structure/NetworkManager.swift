//
//  NetworkManager.swift
//  UrlSessionTypesVJ
//
//  Created by Vijay N on 02/04/25.
//

import Foundation


class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() { }
    
    func requestType1<T: Decodable>(endPoint: EndPointProtocol, responseModel: T.Type) async -> Result<T, USTNetworkError> {
        let request = endPoint.request()
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                return .failure(.statusCodeError)
            }
            
            let model = try JSONDecoder().decode(T.self, from: data)
            return .success(model)
            
        } catch let error as DecodingError {
            return .failure(.jsonError(error.localizedDescription))
        } catch let error {
            return .failure(.apiError(error.localizedDescription))
        }
    }
    
//    URLSession.shared.dataTask(with: URLRequest)
//    URLSession.dataTask(URLSession)

    
    func requestType2() {
        //    URLSession.shared.dataTask(with: URLRequest)
    }
    
    func requestType3() {
        //    URLSession.dataTask(URLSession)
    }
    
    func requestType4() {
//        URLSession.downloadTask(URLSession)
    }
}



