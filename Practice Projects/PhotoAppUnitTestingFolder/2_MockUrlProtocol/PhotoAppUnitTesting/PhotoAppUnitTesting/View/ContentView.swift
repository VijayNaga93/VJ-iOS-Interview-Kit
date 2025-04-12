//
//  ContentView.swift
//  PhotoAppUnitTesting
//
//  Created by NAGARAJAN, VIJAY (V.) on 05/11/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
                
                //            Button {
                //                SignupView()
                //            } label: {
                //                Text("To -> Signup View")
                //            }
                
                NavigationLink {
                    SignupView()
                } label: {
                    Text("To -> Signup View")
                }
                
                
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
