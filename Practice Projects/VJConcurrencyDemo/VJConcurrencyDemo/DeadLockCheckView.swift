//
//  DeadLockCheckView.swift
//  VJConcurrencyDemo
//
//  Created by Vijay N on 04/03/25.
//

import SwiftUI

struct DeadLockCheckView: View {
    
    var viewModel = DeadLockCheckViewModel()
    
    var body: some View {
        Button("Check dead lock") {
            viewModel.checkDeadLock()
        }
    }
}

#Preview {
    DeadLockCheckView()
}

class DeadLockCheckViewModel {
    
    
    func checkDeadLock() {
        let queue = DispatchQueue(label: "com.example.serialQueue")
        
        
        queue.sync {
            print("Task 1 started")
            
            // Synchronously start an another task on the serial queue
            
            queue.async {
                print("Task 2 started")
            }
            
            print("Task 1 finished")
        }
    }
    
    func concurrentQueue() {
        let concurrentQueue = DispatchQueue(label: "com.example.concurrentQueue", attributes: .concurrent)
    }
}



func test1() {
    let queue = DispatchQueue(label: "com.example.serialQueue")
    queue.sync {
        print("Task 1 started")
        queue.sync {
            print("Task 2 started")
        }
        print("Task 1 finished")
    }
}

func test2() {
    let queue = DispatchQueue(label: "com.example.serialQueue")
    queue.sync {
        print("Task 1 started")
        queue.async {
            print("Task 2 started")
        }
        print("Task 1 finished")
    }
}
