//
//  GCDVariationView.swift
//  ConcurrencyByTutorialsVJ
//
//  Created by Vijay N on 27/03/25.
//

import SwiftUI

struct GCDVariationView: View {
    let viewModel = GCDVariationViewModel()
    
    var body: some View {
        Button("GCD variation check") {
            viewModel.syncCheck()
        }
    }
}

#Preview {
    GCDVariationView()
}


class GCDVariationViewModel {
    
    // MARK: - Sync Execution (Blocks Current Thread)
    func syncCheck() {
        let queue1 = DispatchQueue(label: "com.test.check1")
        
        queue1.sync {
            print("syncCheck1")
        }
        
        queue1.sync {
            print("syncCheck2")
        }
        
        queue1.sync {
            print("syncCheck3")
        }
    }
    
    // Use Case: Ensures tasks execute in order, useful when modifying shared resources.
    
    // MARK: - Async Execution (Does Not Block Current Thread)
    func asyncCheck() {
        let queue1 = DispatchQueue(label: "com.test.check1")
        
        queue1.async {
            print("asyncCheck1")
        }
        
        queue1.async {
            print("asyncCheck2")
        }
        
        queue1.async {
            print("asyncCheck3")
        }
    }
    
    // Use Case: Ideal for background tasks like downloading images without blocking the main thread.
    
    // MARK: - Serial Queue (Tasks Execute One by One)
    func serialCheck() {
        let serialQueue = DispatchQueue(label: "com.test.serialQueue")
        
        serialQueue.async {
            print("Serial Task 1")
        }
        
        serialQueue.async {
            print("Serial Task 2")
        }
        
        serialQueue.async {
            print("Serial Task 3")
        }
    }
    
    // Use Case: Used for **data consistency** (e.g., writing to a file, database updates).
    
    // MARK: - Concurrent Queue (Tasks Execute Simultaneously)
    func concurrentCheck() {
        let concurrentQueue = DispatchQueue(label: "com.test.concurrentQueue", attributes: .concurrent)
        
        concurrentQueue.async {
            print("Concurrent Task 1")
        }
        
        concurrentQueue.async {
            print("Concurrent Task 2")
        }
        
        concurrentQueue.async {
            print("Concurrent Task 3")
        }
    }
    
    // Use Case: Used for **parallel execution** (e.g., fetching multiple APIs at once).
    
    // MARK: - Serial Queue with Sync Execution (Tasks Run One After Another)
    func serialSyncCheck() {
        let serialQueue = DispatchQueue(label: "com.test.serialSync")
        
        serialQueue.sync {
            print("Serial Sync Task 1")
        }
        
        serialQueue.sync {
            print("Serial Sync Task 2")
        }
        
        serialQueue.sync {
            print("Serial Sync Task 3")
        }
    }
    
    // Use Case: Used to enforce **strict execution order** (e.g., updating UI elements safely).
    
    // MARK: - Serial Queue with Async Execution (Runs One by One But Does Not Block)
    func serialAsyncCheck() {
        let serialQueue = DispatchQueue(label: "com.test.serialAsync")
        
        serialQueue.async {
            print("Serial Async Task 1")
        }
        
        serialQueue.async {
            print("Serial Async Task 2")
        }
        
        serialQueue.async {
            print("Serial Async Task 3")
        }
    }
    
    // Use Case: Used for **background tasks that must execute in order** (e.g., logging events).
    
    // MARK: - Concurrent Queue with Sync Execution (Blocks, Runs Tasks in Order)
    func concurrentSyncCheck() {
        let concurrentQueue = DispatchQueue(label: "com.test.concurrentSync", attributes: .concurrent)
        
        concurrentQueue.sync {
            print("Concurrent Sync Task 1")
        }
        
        concurrentQueue.sync {
            print("Concurrent Sync Task 2")
        }
        
        concurrentQueue.sync {
            print("Concurrent Sync Task 3")
        }
    }
    
    // Use Case: Used when tasks must execute **in sequence but without parallel execution** (e.g., heavy calculations that depend on each other).
    
    // MARK: - Concurrent Queue with Async Execution (Runs Simultaneously, Does Not Block)
    func concurrentAsyncCheck() {
        let concurrentQueue = DispatchQueue(label: "com.test.concurrentAsync", attributes: .concurrent)
        
        concurrentQueue.async {
            print("Concurrent Async Task 1")
        }
        
        concurrentQueue.async {
            print("Concurrent Async Task 2")
        }
        
        concurrentQueue.async {
            print("Concurrent Async Task 3")
        }
    }
    
    // Use Case: **Best for performance optimization** (e.g., multiple API calls, image processing).
}

/*
 
 Function               Execution Type               Blocks Thread?     Order Guaranteed?       Best Use Case
 syncCheck()              Sync                         ✅ Yes           ✅ Yes              Data consistency (e.g., saving to disk)
 asyncCheck()             Async                       ❌ No           ✅ Yes           Background API calls
 serialCheck()                Async Serial                 ❌ No         ✅ Yes              UI updates, logging
 concurrentCheck()              Async Concurrent      ❌ No             ❌ No          Parallel API calls
 serialSyncCheck()            Sync Serial            ✅ Yes          ✅ Yes           Strict execution (e.g., writing logs in order)
 serialAsyncCheck()           Async Serial                ❌ No        ✅ Yes           Event logging, UI tasks
 concurrentSyncCheck()              Sync Concurrent       ✅ Yes        ✅ Yes          Dependent computations
 concurrentAsyncCheck()             Async Concurrent       ❌ No            ❌ No           Performance optimizations (e.g., parallel tasks)

 */
