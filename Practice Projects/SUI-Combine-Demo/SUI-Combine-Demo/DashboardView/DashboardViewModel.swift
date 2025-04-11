//
//  DashboardViewModel.swift
//  SUI-Combine-Demo
//
//  Created by NAGARAJAN, VIJAY (V.) on 2/23/25.
//

import Foundation
import SwiftUI


class DashboardViewModel: ObservableObject {
    
    @Published var userModel: [UserModel] = []
    @Published var errorMessage: String = ""
    @Published var showAlert: Bool = false
    @Published var isLoading: Bool = false
    
    
    func fetchUserApi() {
        isLoading = true
        
        UserApiWorker.shared.fetchUserApi { resultObj in
            self.isLoading = false
            switch resultObj {
            case .success(let success):
                self.userModel = success
            case .failure(let failure):
                self.errorMessage = failure.localizedDescription
                self.showAlert.toggle()
            }
        }
        
    }
}



