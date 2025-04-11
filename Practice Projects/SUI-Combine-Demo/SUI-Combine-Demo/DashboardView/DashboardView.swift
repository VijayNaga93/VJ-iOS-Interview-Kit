//
//  DashboardView.swift
//  SUI-Combine-Demo
//
//  Created by NAGARAJAN, VIJAY (V.) on 2/23/25.
//

import SwiftUI

struct DashboardView: View {
    //    @EnvironmentObject var authManager: AuthManager
    //    @ObservedObject var viewModel: DashboardViewModel
    @State private var showProfileView = false
    @State private var showEqualizerView = false
    
    @ObservedObject var viewModel: DashboardViewModel
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                } else if viewModel.userModel.isEmpty {
                    Button("Fethch User Api") {
                        viewModel.fetchUserApi()
                    }
                } else {
                    List(viewModel.userModel) { user in
                        Text(user.name)
                    }
                }
                
            }
            .navigationTitle("Dashboard")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.green).opacity(0.5)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("", systemImage: "music.note") {
                        showEqualizerView.toggle()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("", systemImage: "person.crop.circle") {
                        showProfileView.toggle()
                        print("Profile icon tapped")
                    }
                }
            }
            .sheet(isPresented: $showProfileView) {
                ProfileView(viewModel: ProfileViewModel())
            }
            .fullScreenCover(isPresented: $showEqualizerView) {
                EqualizerView(viewModel: EqualizerViewModel())
            }
            .alert(viewModel.errorMessage, isPresented: $viewModel.showAlert) { }
            
        }
        
        
    }
}

#Preview {
    DashboardView(viewModel: DashboardViewModel())
}
