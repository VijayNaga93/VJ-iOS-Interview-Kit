//
//  UserListViewTCA.swift
//  TCADemo1
//
//  Created by Vijay N on 07/04/25.
//

import ComposableArchitecture
import SwiftUI

struct QuoteFeature: Reducer {
    struct State: Equatable {
        var loadingState = LoadingState.loading
    }
    
    enum LoadingState: Equatable {
        case loading
        case result([QuoteResponse])
        case error
    }
    
    enum Action: Equatable {
        case fetchQuote
        case updateQuote([QuoteResponse])
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .fetchQuote:
                // Normal - only 1 fuction
                return .run { send in
                    @Dependency(\.apiClient) var apiClient
                    let response = try await apiClient.fetchRandomquote()
                    await send(.updateQuote(response))
                }
                
                // Parallel -   /// Merges a sequence of effects together into a single effect, which runs the effects at the same
                /// time.
                
//                return .merge(
//                     .run { send in
//                        @Dependency(\.apiClient) var apiClient
//                        let response = try await apiClient.fetchRandomquote()
//                        await send(.updateQuote(response))
//                    }
//
//                        .run { send in
//                           @Dependency(\.apiClient) var apiClient
//                           let response = try await apiClient.fetchRandomquote()
//                           await send(.updateQuote(response))
//                       }
//
//                )
                
                // serial -   /// Concatenates a collection of effects together into a single effect, which runs the effects one
                /// after the other.
//                return .concatenate()
                
            case let .updateQuote(namesList):
                state.loadingState = .result(namesList)
                return .none
            }
        }
    }
}

struct QuoteView: View {
    let store: StoreOf<QuoteFeature>
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack {
                switch viewStore.loadingState {
                case .loading:
                    Text("Loading")
                case .result(let names):
                    ForEach(names) { res in
                        Text(res.name)
                    }
                case .error:
                    Text("loading error")
                }
            }
            .onAppear {
                viewStore.send(.fetchQuote)
            }
        }
        
    }
}

struct APIClient {
    var fetchRandomquote: () async throws -> [QuoteResponse]
//    var fetchRandom1: String
}

extension APIClient: DependencyKey {
    static let liveValue = Self {
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")
        let (data, _) = try await URLSession.shared.data(from: url!)
        let response = try JSONDecoder().decode([QuoteResponse].self, from: data)
        return response
    }
    
    static var testValue: APIClient =  APIClient {
        return [QuoteResponse(name: "Test Quote1"),
                QuoteResponse(name: "Test Quote2")
               ]
    }
    
//    static let liveValue = APIClient(fetchRandomquote: {
//        
//    }, fetchRandom1: "vvv")
}

extension DependencyValues {
    var apiClient: APIClient {
        get { self[APIClient.self] }
        set { self[APIClient.self] = newValue }
    }
}

struct QuoteResponse: Codable, Equatable, Identifiable {
    let id = UUID()
    let name: String
}

#Preview {
    QuoteView(
        store: Store(initialState: QuoteFeature.State()) {
            QuoteFeature()
        }
    )
}
