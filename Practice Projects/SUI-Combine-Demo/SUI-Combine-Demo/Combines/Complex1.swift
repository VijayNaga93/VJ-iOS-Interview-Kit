//
//  Complex1.swift
//  SUI-Combine-Demo
//
//  Created by Vijay N on 11/04/25.
//

import SwiftUI
import Combine

enum FetchError: Error {
    case apiFailure
    case noUser
}


struct PostModel: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class NetworkService {
    static let shared = NetworkService()
    
    var cancellables = Set<AnyCancellable>()
    
    func fetchUserProfile() -> AnyPublisher<[UserModel], Error> {
        
        let url: URL = URL(string: "https://jsonplaceholder.typicode.com/users")!
        //        let request = URLRequest(url: url)
        
        
        //       vijay understand the below 3
        //        URLSession.shared.dataTask(with: <#T##URLRequest#>)
        //        URLSession.shared.dataTask(with: <#T##URLRequest#>, completionHandler: <#T##(Data?, URLResponse?, (any Error)?) -> Void#>)
        //        URLSession.shared.dataTaskPublisher(for: <#T##URL#>)
        
        let dataPublisher = URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [UserModel].self, decoder: JSONDecoder())
        // Publishers.Decode<Publishers.MapKeyPath<URLSession.DataTaskPublisher, JSONDecoder.Input>, UserModel, JSONDecoder>
            .eraseToAnyPublisher()
        //        Publisher<UserModel, any Publishers.Decode<Publishers.MapKeyPath<URLSession.DataTaskPublisher, JSONDecoder.Input>, UserModel, JSONDecoder>.Failure>
        //        vijay understand the above 2
        
        return dataPublisher
    }
    
    func fetchUserProfile2() {
        
        //        let url: URL = URL(string: "https://jsonplaceholder.typicode.com/users")!
        let url: URL = URL(string: "https://sampletest")!
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .catch({ err in
                //                Just(Data())
                Just(self.fallBackJson())
            })
            .decode(type: [UserModel].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("User api data fetch completed...")
                case .failure(let err):
                    print("User api data fetch failed with error \(err)")
                }
            }, receiveValue: { data in
                print("Received data \(data)")
            })
            .store(in: &cancellables)
    }
    
    func fetchUserProfile3() {
        
        //        let url: URL = URL(string: "https://jsonplaceholder.typicode.com/users")!
        let url: URL = URL(string: "https://sampletest")!
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .tryCatch { error -> Just<Data> in
                // Handle the error explicitly
                print("Network error occurred: \(error)")
                throw error // Re-throw the error to let it propagate
            }
            .decode(type: [UserModel].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("User api data fetch completed...")
                case .failure(let err):
                    print("User api data fetch failed with error \(err)")
                }
            }, receiveValue: { data in
                print("Received data \(data)")
            })
            .store(in: &cancellables)
    }
    
    func fetchUserProfile4() {
        
        let url: URL = URL(string: "https://jsonplaceholder.typicode.com/users")!
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .catch({ err in
                Just(self.fallBackJson())
            })
            .decode(type: [UserModel].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("User api data fetch completed...")
                case .failure(let err):
                    print("User api data fetch failed with error \(err)")
                }
            }, receiveValue: { data in
                print("Received data \(data)")
            })
            .store(in: &cancellables)
    }
    
    func fallBackJson() -> Data {
        let string = "[{\"id\":5,\"name\":\"vijay\",\"username\":\"vijayVJ5\"}]"
        let data = string.data(using: .utf8)!
        
        do {
            if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,Any>]
            {
                print(jsonArray) // use the json here
            } else {
                print("bad json")
            }
        } catch let error as NSError {
            print(error)
        }
        
        
        return data
    }
}

class Complex1ViewModel: ObservableObject {
    @Published var userModel: [UserModel] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchUserProfileData() {
        //        let cancellable = NetworkService().fetchUserProfile()
        //        let cancellable = NetworkService.shared.fetchUserProfile()
        NetworkService.shared.fetchUserProfile()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("User api data fetch completed...")
                case .failure(let err):
                    print("User api data fetch failed with error \(err)")
                }
            } receiveValue: { data in
                print("Received data \(data)")
                self.userModel = data
            }
            .store(in: &cancellables)
    }
    
    func fetchUserProfileData2() {
        NetworkService.shared.fetchUserProfile2()
    }
    
    func fetchUserProfileAndPostData() {
        //        NetworkService.shared.fetchProfileAndPostData()
        backPressureManagement()
    }
    
    func backPressureManagement() {
        let slowPublisher = (0...1000).publisher
            .delay(for: .milliseconds(100), scheduler: DispatchQueue.global())
        
        
        slowPublisher
            .buffer(size: 10, prefetch: .byRequest, whenFull: .dropOldest)
            .sink { value in
                print("Received value \(value)")
                //                Thread.sleep(forTimeInterval: 0.15)
            }
            .store(in: &cancellables)
    }
    
    func checkingFailPublisher() {
        
        NetworkService.shared.checkingFailPublisherWithUserApi()
            .sink { completion in
                switch completion {
                case .finished:
                    print("Api call finished")
                case let .failure(err):
                    print("Api call failed with \(err).")
                }
            } receiveValue: { value in
                print("Api call received user \(value.count) count.")
            }
            .store(in: &cancellables)
    }
    
    func checkingFuturePublisher() {
        NetworkService.shared.checkingFuturePublisherWithUserApi()
            .sink { completion in
                switch completion {
                case .finished:
                    print("Api call finished")
                case let .failure(err):
                    print("Api call failed with \(err).")
                }
            } receiveValue: { value in
                print("Api call received user \(value.id) -- \(value.name)")
            }
            .store(in: &cancellables)
    }
    
    func checkingFuturePublisher2() {
        NetworkService.shared.checkingFuturePublisherWithUserApi2()
            .sink { completion in
                switch completion {
                case .finished:
                    print("Api call finished")
                case let .failure(err):
                    print("Api call failed with \(err).")
                }
            } receiveValue: { value in
                print("Api call received user \(value.id) -- \(value.name)")
            }
            .store(in: &cancellables)
        
    }
}

struct Complex1: View {
    @StateObject var vm = Complex1ViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("User Model List")
                Button {
                    //                    vm.fetchUserProfileData()
                    vm.fetchUserProfileData2()
                } label: {
                    Text("Fetch User data")
                }
                
                //                List(vm.$userModel) { user in
                //
                //                }
                
                
                //                List(vm.userModel, id: \.id) { user in
                //                    Text("\(user.name)")
                //                }
                
                List(vm.userModel) { user in
                    Text("\(user.name)-- \(user.username)")
                }
            }
        }
        .navigationTitle("User Model Titlte")
        
    }
}

#Preview {
    Complex1()
}

/*
 https://jsonplaceholder.typicode.com/users
 
 */

/*
 
 func tryMap<T>(_ transform: @escaping (Self.Output) throws -> T) -> Publishers.TryMap<Self, T>
 
 func mapError<E>(_ transform: @escaping (Self.Failure) -> E) -> Publishers.MapError<Self, E> where E : Error
 
 func sink(
 receiveCompletion: @escaping ((Subscribers.Completion<Self.Failure>) -> Void),
 receiveValue: @escaping ((Self.Output) -> Void)
 ) -> AnyCancellable
 
 Publishers.MapError<Publishers.TryMap<Publishers.Sequence<[Int], Never>, Int>, NumberError>.Output
 
 */

extension NetworkService {
    
    func fetchProfileAndPostData() {
        //        let userURL = URL(string: "https://jsonplaceholder.typicode.com/users")!
        let userURL: URL = URL(string: "https://sampletest")!
        
        
        let postsURL = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        //        let postsURL: URL = URL(string: "https://sampletest")!
        
        
        let userPublisher = URLSession.shared.dataTaskPublisher(for: userURL)
            .map(\.data)
            .decode(type: [UserModel].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
        
        let postPublisher = URLSession.shared.dataTaskPublisher(for: postsURL)
            .map(\.data)
            .decode(type: [PostModel].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
        
        Publishers.Zip(userPublisher, postPublisher)
            .sink { completion in
                switch completion {
                case .finished:
                    print("Data fetching completed...")
                case let .failure(err):
                    print("Error fetching data: \(err.localizedDescription)")
                }
            } receiveValue: { users, posts in
                for user in users {
                    let post = posts.filter{ $0.userId == user.id }
                    print("This \(user.name) has \(post.count) posts.")
                }
            }
            .store(in: &cancellables)
        
    }
    
    
    
    func checkingFailPublisherWithUserApi() -> AnyPublisher<[UserModel], Error> {
        
        //        let userURLStr = "https://jsonplaceholder.typicode.com/users"
        let userURLStr = ""
        
        guard let userURL = URL(string: userURLStr) else {
            return Fail(outputType: [UserModel].self, failure: CustomProjError.badURL).eraseToAnyPublisher()
        }
        
        let userPublisher = URLSession.shared.dataTaskPublisher(for: userURL)
            .map(\.data)
            .decode(type: [UserModel].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
        
        return userPublisher
    }
    
    func checkingFuturePublisherWithUserApi() -> AnyPublisher<UserModel, Error> {
        let userURL = URL(string: "https://jsonplaceholder.typicode.com/users")!
        
        let userPublisher = URLSession.shared.dataTaskPublisher(for: userURL)
            .map(\.data)
            .decode(type: [UserModel].self, decoder: JSONDecoder())
            .flatMap({ users in
                Future<UserModel, Never> { promise in
                    Task {
                        let selectedUser = await self.processUserDataWithFuturePublisher(usersArr: users)
                        promise(.success(selectedUser))
                    }
                }
            })
            .eraseToAnyPublisher()
        
        return userPublisher
    }
    
    func processUserDataWithFuturePublisher(usersArr: [UserModel]) async -> UserModel {
        return await withCheckedContinuation { continuation in
            if let processedData = usersArr.first(where: { $0.id == 5 }) { // if we check for 55, there is no else case so code wont work.
                continuation.resume(returning: processedData)
            }
            
        }
    }
    
    func checkingFuturePublisherWithUserApi2() -> Future<UserModel, FetchError> {
        let userURL = URL(string: "https://jsonplaceholder.typicode.com/users")!
        
        let userPublisher = URLSession.shared.dataTaskPublisher(for: userURL)
            .map(\.data)
            .decode(type: [UserModel].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
        
        return Future { promise in
            userPublisher.sink { completion in
                switch completion {
                case .finished:
                    print("Api fetch finished")
                case .failure(let err):
                    promise(.failure(.apiFailure))
                }
            } receiveValue: { value in
                
                if let selectedUser = value.first(where: { $0.id == 55}) {
                    promise(.success(selectedUser))
                } else {
                    promise(.failure(.noUser))
                }
            }
            .store(in: &self.cancellables)
        }
    }
}

