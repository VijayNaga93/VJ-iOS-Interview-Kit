//
//  UserModel.swift
//  PhotoAppUnitTesting
//
//  Created by NAGARAJAN, VIJAY (V.) on 11/18/24.
//

import Foundation

struct UserModel : Codable, Identifiable {
    let id : Int?
    let name : String?
    let username : String?
    let email : String?
    let address : Address?
    let phone : String?
    let website : String?
    let company : Company?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case username = "username"
        case email = "email"
        case address = "address"
        case phone = "phone"
        case website = "website"
        case company = "company"
    }
}

struct Address : Codable {
    let street : String?
    let suite : String?
    let city : String?
    let zipcode : String?
    let geo : Geo?
    
    enum CodingKeys: String, CodingKey {
        
        case street = "street"
        case suite = "suite"
        case city = "city"
        case zipcode = "zipcode"
        case geo = "geo"
    }
}

struct Company : Codable {
    let name : String?
    let catchPhrase : String?
    let bs : String?
    
    enum CodingKeys: String, CodingKey {
        
        case name = "name"
        case catchPhrase = "catchPhrase"
        case bs = "bs"
    }
}

struct Geo : Codable {
    let lat : String?
    let lng : String?
    
    enum CodingKeys: String, CodingKey {
        
        case lat = "lat"
        case lng = "lng"
    }
}
