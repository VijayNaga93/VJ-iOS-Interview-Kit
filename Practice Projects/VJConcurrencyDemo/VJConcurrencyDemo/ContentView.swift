//
//  ContentView.swift
//  VJConcurrencyDemo
//
//  Created by Vijay N on 11/04/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                NavigationLink("Actor") {
                    ActorCheckView(amountNeeded: "20")
                }
                
                NavigationLink("Serial Execution") {
                    SerialExecutorCheckView()
                }
                
                //                Isolated-NonIsolated
                NavigationLink("ActorNonIsolated") {
                    ActorIsolationCheckView(amountNeeded: "20")
                }
                
                NavigationLink("Dead Lock Check") {
                    DeadLockCheckView()
                }
                
                //            TODO: - Main Actor
                //                NavigationLink("Main Actor") {
                //                    ActorCheckView(amountNeeded: "20")
                //                }
                
            }
        }
    }
}

#Preview {
    ContentView()
}
