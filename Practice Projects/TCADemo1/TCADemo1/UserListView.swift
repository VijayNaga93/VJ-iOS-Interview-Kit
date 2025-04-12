//
//  UserListView.swift
//  TCADemo1
//
//  Created by Vijay N on 07/04/25.
//

import SwiftUI
import ComposableArchitecture
import Combine

enum APIError: Error {
    case invalidURL
    case apiError(message: String)
}

//struct UserListReducer: Reducer {
//    struct State: Equatable, Identifiable {
//        var userList: [UserModel] = []
//    }
//    
//    enum Action: Equatable {
//        case fetchUser
//        case userResponse(Result<[UserModel], Error>)
//    }
//    
//    
//    var body: some Reduce<State, Action> {
//        Reduce { state, action in
//            switch action {
//            case .fetchUser:
//                    .run {
//                        
//                    }
//            case .userResponse(.success(let user)):
//                
//            case .userResponse(.failure(let error)):
//                
//                
//            }
//        }
//    }
//}



//struct UserListView1: View {
//    
//    let store: Store<UserListReducer.State, UserListReducer.Action>
//    
//    var body: some View {
//        
//        WithViewStore(self.store, observe: { $0 }) { viewStore in
//            VStack(spacing: 20) {
//                Text("User list view")
//                
//                Button("Fetch User") {
//                    viewStore.send(.fetchUser)
//                }
//                
//                List(viewStore.userList) { user in
//                    Text(user.name)
//                }
//            }
//        }
//    }
//}

struct UserListView: View {
    
    @StateObject var viewModel = UserListViewModel()
    
    var body: some View {
        
            VStack(spacing: 20) {
                Text("User list view")
                
                Button("Fetch User") {
                    viewModel.fetchUser()
                }
                
                List(viewModel.userModel) { user in
                    Text(user.name)
                }
            }
        }
}

//#Preview {
//    UserListView()
//}


class UserListViewModel: ObservableObject {
    
    var cancellables = Set<AnyCancellable>()
    
    @Published var userModel: [UserModel] = []
    
    func fetchUser() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        
        //        let publisher = URLSession.shared.dataTaskPublisher(for: url)
        
        URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .map(\.data)
            .decode(type: [UserModel].self, decoder: JSONDecoder())
            .sink { completion in
                switch completion {
                case .finished:
                    debugPrint("fetchUser api call finished")
                case .failure(let error):
                    debugPrint("fetchUser api error -> \(error)")
                }
            } receiveValue: { userModel in
                self.userModel = userModel
            }
            .store(in: &cancellables)
        
    }
}


// "https://jsonplaceholder.typicode.com/users"


func debugPrint(_ value: Any) {
    #if DEBUG
    print(value)
    #endif
}
