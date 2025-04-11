//
//  SUI_Combine_DemoApp.swift
//  SUI-Combine-Demo
//
//  Created by Vijay N on 11/04/25.
//

import SwiftUI

@main
struct SUI_Combine_DemoApp: App {
    @StateObject var authManager = AuthManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authManager)
        }
    }
}
