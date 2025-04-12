//
//  EndPointProtocol.swift
//  UrlSessionTypesVJ
//
//  Created by Vijay N on 02/04/25.
//

import Foundation

protocol EndPointProtocol {
    var baseURL: String { get }
    var path: String { get }
    var method: String { get }
    var body: Data? { get }
    var headers: [String: String] { get }
    
    func request() -> URLRequest
}
