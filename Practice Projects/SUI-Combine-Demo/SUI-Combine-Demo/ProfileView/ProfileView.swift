//
//  ProfileView.swift
//  SUI-Combine-Demo
//
//  Created by NAGARAJAN, VIJAY (V.) on 2/23/25.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authManager: AuthManager
    
    @StateObject var viewModel: ProfileViewModel
    @Environment(\.dismiss) var dismissControl
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                
                ProfileFieldTypeOne(title: "Name", value: viewModel.profileModel?.name ?? "")
                ProfileFieldTypeOne(title: "Age", value: String(viewModel.profileModel?.age ?? 0))
                ProfileFieldTypeOne(title: "Gender", value: viewModel.profileModel?.gender ?? "")
                Button("Save") {
                    
                }
                Button("Log out") {
                    authManager.logout()
                }
            }
        }
            .navigationTitle("Profile")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("", systemImage: "xmark") {
                        dismissControl()
                    }
                }
            }
        }
        
        
    }
}

#Preview {
    ProfileView(viewModel: ProfileViewModel(profileModel: ProfileModel(name: "Vijay", age: 32, gender: "M")))
}

struct ProfileFieldTypeOne: View  {
    var title: String
    @State private var value: String
    
    init(title: String, value: String) {
        self.title = title
        self.value = value
    }
    
    var body: some View {
        VStack(alignment:.leading, spacing: 20) {
            Text(title)
            TextField("", text: $value)
        }
        .modifier(FieldViewModifierT1())
    }
}

struct FieldViewModifierT1: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(.green).opacity(0.2)
            .shadow(color: .orange, radius: 5.0, x: 5.0, y: 3.0)
    }
    
    
}

