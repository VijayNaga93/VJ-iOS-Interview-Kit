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
            

            customViewSignUpOrLogIn(isLogin: viewModel.isLogin)
            
            MyStack {
                Text("View 1")
                Text("View 2")
            }


        }
        .padding(20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.green)
        
        
    }
    
    @ViewBuilder
    func customViewSignUpOrLogIn(isLogin: Bool) -> some View {
        VStack(spacing: 20) {
            if isLogin {
                Text("Heart")
                TextField("Enter UserName", text: $viewModel.userName)
                TextField("Enter Password", text: $viewModel.password)
                    .textContentType(.password)
                
                Button("Log In") {
                    Task {
                        await viewModel.validateLogin()
                    }
                }
                .customButtonStyle1()
    //            .modifier(CustomButtonStyle1())
                .alert("Login failed", isPresented: $viewModel.showAlert) {
                }
                .onChange(of: viewModel.isSuccess) {
                    authManager.login()
                }
            } else {
                Image(systemName: "heart").foregroundStyle(.red)
                TextField("Enter Preferred UserName", text: $viewModel.preferredUserName)
                TextField("Enter MailID", text: $viewModel.emailId)
                
                Button("Sign Up") {
                    Task {
                        await viewModel.validateLogin()
                    }
                }
                .customButtonStyle2()
    //            .modifier(CustomButtonStyle2())
                .alert("Login failed", isPresented: $viewModel.showAlert) {
                }
                .onChange(of: viewModel.isSuccess) {
                    authManager.login()
                }
            }
        }
    }
}

#Preview {
    LoginView(viewModel: LoginViewModel())
}


//Example for  @ViewBuilders
struct MyStack<Content: View>: View {
    let content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) { // let us create multiple view in a closure
//    init(content: @escaping () -> Content) { // only able to create one view
        self.content = content
    }

    var body: some View {
        VStack {
            content()
        }
    }
    
    /*
     // Single view creation:
     MyStack {
         Text("123")
     }
     
     // Multiple view creation:
     MyStack {
         Text("123")
         Text("321")
     }
     */
}
