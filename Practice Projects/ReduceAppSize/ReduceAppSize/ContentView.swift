//
//  ContentView.swift
//  ReduceAppSize
//
//  Created by Vijay N on 25/03/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                
                NavigationLink("OnDemand Check") {
                    OnDemandCheckView()
                }
            }
            .padding()
        }
        
    }

}

#Preview {
    ContentView()
}


