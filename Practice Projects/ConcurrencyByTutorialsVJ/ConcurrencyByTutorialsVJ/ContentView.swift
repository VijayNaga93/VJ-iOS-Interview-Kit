//
//  ContentView.swift
//  ConcurrencyByTutorialsVJ
//
//  Created by Vijay N on 27/03/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {

                Text("Dispatch Queue")
                    .foregroundStyle(.red)
                NavigationLink("GCDandOperationsView") {
                    GCDandOperationsView()
                }
                
                NavigationLink("GroupsandSemaphoresView") {
                    GroupsandSemaphoresView()
                }
                
                NavigationLink("DispatchWorkItemView") {
                    DispatchWorkItemView()
                }
                
                Text("Operation Queue")
                    .foregroundStyle(.red)
                
                NavigationLink("BlockOperationView") {
                    BlockOperationView()
                }
                
                NavigationLink("OperationQueueView") {
                    OperationQueueView()
                }
                
                Text("Custom Operation Queue")
                    .foregroundStyle(.red)
                
                NavigationLink("CustomOperationView") {
                    CustomOperationView()
                }
                
                NavigationLink("FetchImageView") {
                    FetchImageView()
                }
                
                NavigationLink("FetchCancelImageView") {
                    FetchCancelImageView()
                }
                
                
                
            }
        }
    }
}

#Preview {
    ContentView()
}
