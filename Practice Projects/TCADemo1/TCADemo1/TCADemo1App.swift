//
//  TCADemo1App.swift
//  TCADemo1
//
//  Created by Vijay N on 07/04/25.
//

import SwiftUI
import ComposableArchitecture

@main
struct TCADemo1App: App {
    var body: some Scene {
        WindowGroup {
//            ContentView()
//            UserListView()
            QuoteView(
                store: Store(initialState: QuoteFeature.State()) {
                    QuoteFeature()
                }
            )
        }
    }
}
