//
//  UserModel.swift
//  SUI-Combine-Demo
//
//  Created by NAGARAJAN, VIJAY (V.) on 2/24/25.
//

import SwiftUI
import Combine

public enum CustomProjError: Error {
    case badURL
    case apiError
    case unknownError
    case none
}

struct UserModel: Codable, Identifiable {
    //    let id: Int
    //    init(from decoder: any Decoder) throws {
    //        let container = try decoder.container(keyedBy: CodingKeys.self)
    //        self.name = try container.decode(String.self, forKey: .name)
    //        self.username = try container.decode(String.self, forKey: .username)
    //        self.email = try container.decode(String.self, forKey: .email)
    //        self.address = try container.decode(Address.self, forKey: .address)
    //        self.phone = try container.decode(String.self, forKey: .phone)
    //        self.website = try container.decode(String.self, forKey: .website)
    //        self.company = try container.decode(Company.self, forKey: .company)
    //    }
    //    let id = UUID()
    
    var id: Int
    let name: String
    let username: String
    let email: String?
    let address: Address?
    let phone: String?
    let website: String?
    let company: Company?
}

struct Address: Codable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: Geo
}

struct Geo: Codable {
    let lat: String
    let lng: String
}

struct Company: Codable {
    let name: String
    let catchPhrase: String
    let bs: String
}
