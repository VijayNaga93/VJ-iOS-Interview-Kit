//
//  ContentView.swift
//  SUI-Combine-Demo
//
//  Created by Vijay N on 11/04/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authManager: AuthManager
    
    var body: some View {
        if authManager.isLoggedIn {
            DashboardView(viewModel: DashboardViewModel())
        } else {
            LoginView(viewModel: LoginViewModel())
        }
        
    }
}

#Preview {
    ContentView()
}
