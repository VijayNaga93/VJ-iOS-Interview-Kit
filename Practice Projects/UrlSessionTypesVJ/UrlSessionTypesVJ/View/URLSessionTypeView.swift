//
//  URLSessionTypeView.swift
//  UrlSessionTypesVJ
//
//  Created by Vijay N on 01/04/25.
//

import SwiftUI

struct URLSessionTypeView: View {
    
    @StateObject private var viewModel = URLSessionTypeViewModel()
    
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text(viewModel.apiResponseStr)
            
            Button("CheckType1") {
                Task {
                    await viewModel.checkType1()
                }
            }
            
//            List(viewModel.userModel) { user in
//                Text(user.name)
//            }
            
            List(viewModel.userModel, id: \.name) { user in
                Text(user.name)
            }
        }
    }
}

#Preview {
    URLSessionTypeView()
}


class URLSessionTypeViewModel: ObservableObject {
    
    @Published var apiResponseStr: String = ""
    @Published var userModel: [UserModel] = []
    
    func checkType1() async {
        let tempFuncName = "checkType1"
        let userApiResponse = await NetworkManager.shared.requestType1(endPoint: UserEndPoint.getUsers, responseModel: [UserModel].self)
        
        DispatchQueue.main.async {
            switch userApiResponse {
            case .success(let success):
                print("\(tempFuncName) -- success --> \(success)")
                self.apiResponseStr = "\(tempFuncName)--> \(success.first?.name ?? "")"
                self.userModel = success
            case .failure(let failure):
                print("\(tempFuncName) -- failure --> \(failure)")
                self.apiResponseStr = "\(tempFuncName)--> \(failure.localizedDescription)"
            }
        }
    }
    
    func checkType2() async {
        let tempFuncName = "checkType2"
        let userApiResponse = await NetworkManager.shared.requestType1(endPoint: UserEndPoint.getUsers, responseModel: [UserModel].self)
        
        DispatchQueue.main.async {
            switch userApiResponse {
            case .success(let success):
                print("\(tempFuncName) -- success --> \(success)")
                self.apiResponseStr = "\(tempFuncName)--> \(success.first?.name ?? "")"
                self.userModel = success
            case .failure(let failure):
                print("\(tempFuncName) -- failure --> \(failure)")
                self.apiResponseStr = "\(tempFuncName)--> \(failure.localizedDescription)"
            }
        }
    }
    
    func checkType3() async {
        let tempFuncName = "checkType3"
        let userApiResponse = await NetworkManager.shared.requestType1(endPoint: UserEndPoint.getUsers, responseModel: [UserModel].self)
        
        DispatchQueue.main.async {
            switch userApiResponse {
            case .success(let success):
                print("\(tempFuncName) -- success --> \(success)")
                self.apiResponseStr = "\(tempFuncName)--> \(success.first?.name ?? "")"
                self.userModel = success
            case .failure(let failure):
                print("\(tempFuncName) -- failure --> \(failure)")
                self.apiResponseStr = "\(tempFuncName)--> \(failure.localizedDescription)"
            }
        }
    }
    
}



/*
 https://jsonplaceholder.typicode.com/users
 */
