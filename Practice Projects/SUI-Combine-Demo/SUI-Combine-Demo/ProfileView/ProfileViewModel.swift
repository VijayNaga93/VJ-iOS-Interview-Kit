//
//  ProfileViewModel.swift
//  SUI-Combine-Demo
//
//  Created by NAGARAJAN, VIJAY (V.) on 2/23/25.
//

import Foundation
import SwiftUI

struct ProfileModel {
    var name: String?
    var age: Int?
    var gender: String?
}

class ProfileViewModel: ObservableObject {
    //    @AppStorage("userProfile") var userProfile: ProfileModel = ProfileModel()
    //    @AppStorage("userProfileName") var userProfileName: String?
    
    var profileModel: ProfileModel?
    
    
    init(profileModel: ProfileModel? = nil) {
        self.profileModel = profileModel
    }
    
    
    
    
}
