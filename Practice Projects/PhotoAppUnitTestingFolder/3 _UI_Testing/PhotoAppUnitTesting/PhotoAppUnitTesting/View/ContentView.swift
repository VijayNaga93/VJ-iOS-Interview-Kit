//
//  ContentView.swift
//  PhotoAppUnitTesting
//
//  Created by NAGARAJAN, VIJAY (V.) on 05/11/24.
//

import SwiftUI

struct ContentView: View {
    @State var title: String
    
    var body: some View {
        NavigationStack {
            VStack {
                Text(title)
                    .frame(height: 100)
                    .foregroundStyle(.orange)
                NavigationLink {
                    SignupView()
                } label: {
                    Text("Signup View")
                }
   
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.yellow)
            .navigationTitle("Content View")
            .navigationBarTitleDisplayMode(.inline)
        }
        

    }
    
}

#Preview {
    ContentView(title: "This is the first view")
}
