//
//  LoginViewModel.swift
//  SUI-Combine-Demo
//
//  Created by NAGARAJAN, VIJAY (V.) on 2/23/25.
//

import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var isLogin: Bool = false
    
    @Published var userName: String = ""
    @Published var password: String = ""
    @Published var showAlert: Bool = false
    @Published var isSuccess: Bool = false
    
    @Published var preferredUserName: String = ""
    @Published var emailId: String = ""
    
    func validateLogin() async {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
//            if self.userName == "111" && self.password == "111" {
            if self.userName == "" && self.password == "" {
                self.isSuccess = true
            } else {
                self.showAlert = true
            }
        })
    }
    
    func signUpFlow() async {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
//            if self.userName == "111" && self.password == "111" {
            if self.userName == "" && self.password == "" {
                self.isSuccess = true
            } else {
                self.showAlert = true
            }
        })
    }
    
}
