//
//  SignupView.swift
//  PhotoAppUnitTesting
//
//  Created by NAGARAJAN, VIJAY (V.) on 11/18/24.
//

import SwiftUI

struct SignupView: View {
    
    @ObservedObject var viewModel = SignupViewModel()
    
    var body: some View {
        VStack {
            Text("SignupView")
                .frame(height: 100)
                .padding(30)
                .background(.blue)
            if let signupModelValue = viewModel.signupModel {
                Text("Status: \(signupModelValue.status)")
            } else {
                Text("Status: No")
            }
        }
        .onAppear {
            Task {
                await signupWebServiceCall()
            }
        }
    }
    
    func signupWebServiceCall() async {
        let formModel = SignupFormRequestModel(firstName: "Sergey", lastName: "Kargopolov", email: "test@test.com", password: "12345678")
        let webService = SignupWebService(urlString: SignupConstants.signupURLString)
        webService.signup(withForm: formModel) { signupResponseModel, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("error-->\(error)")
                }
                if let signupModel = signupResponseModel {
                    viewModel.signupModel = signupModel
                }
            }
        }
    }
}



#Preview {
    SignupView()
}
