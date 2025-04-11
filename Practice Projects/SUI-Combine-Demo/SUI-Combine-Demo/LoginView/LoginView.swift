//
//  LoginView.swift
//  SUI-Combine-Demo
//
//  Created by NAGARAJAN, VIJAY (V.) on 2/23/25.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authManager: AuthManager
    @StateObject var viewModel: LoginViewModel
    
    @Environment(\.colorScheme) private var colorSchemeValue
    
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            
            if colorSchemeValue == .dark {
                Text("Dark mode enabled")
            } else {
                Text("Light mode enabled")
            }
            
            Image(systemName: "paperplane.fill")
                .foregroundStyle(.yellow)
            
            TextField("Enter UserName", text: $viewModel.userName)
            TextField("Enter Password", text: $viewModel.password)
                .textContentType(.password)
                
            
            Button("Log In") {
                Task {
                    await viewModel.validateLogin()
                }
            }
            .alert("Login failed", isPresented: $viewModel.showAlert) {
            }
            .onChange(of: viewModel.isSuccess) {
                authManager.login()
            }

        }
        .padding(20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.green)
        
        
    }
}

#Preview {
    LoginView(viewModel: LoginViewModel())
}
