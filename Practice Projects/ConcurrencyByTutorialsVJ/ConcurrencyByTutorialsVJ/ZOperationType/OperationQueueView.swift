//
//  OperationQueueView.swift
//  ConcurrencyByTutorialsVJ
//
//  Created by Vijay N on 30/03/25.
//

import SwiftUI

struct OperationQueueView: View {
    
    let viewModel = OperationQueueViewModel()
    
    var body: some View {
        
        VStack(spacing: 20) {
            Button("Operation Queue Check") {
                viewModel.operationQueueCheck()
            }
            
            Button("Operation Queue Serial Check") {
                viewModel.operationQueueSerialCheck()
            }
            
            Button("Operation Dependency Check") {
                viewModel.operationDependenciesCheck()
            }
            
            Button("Dispatch Group Implementation Using Operation Queue Check") {
                viewModel.dispatchGroupImplementationUsingOperationQueue()
            }
            
            Button("Cancelling Operation") {
                viewModel.cancellingOperation2()
            }

            
            
        }
        
    }
}

#Preview {
    OperationQueueView()
}


class OperationQueueViewModel {
    
    func operationQueueCheck() {
        
        let operationQueue = OperationQueue()
        let block1 = BlockOperation()
        let block2 = BlockOperation {
            for val in 0...5 {
                print("block2 -> \(val)")
            }
        }
        
        block1.addExecutionBlock {
            for val in 0...5 {
                print("block1 -> \(val)")
            }
        }
        
        operationQueue.addOperation(block1)
        operationQueue.addOperation(block2)
        
    }
    
    func operationQueueSerialCheck() {
        
        let operationQueue = OperationQueue()
        let block1 = BlockOperation()
        let block2 = BlockOperation {
            for val in 0...5 {
                print("block2 -> \(val)")
            }
        }
        
        block1.addExecutionBlock {
            for val in 0...5 {
                print("block1 -> \(val)")
            }
        }
        
        operationQueue.maxConcurrentOperationCount = 1
        
        operationQueue.addOperation(block1)
        operationQueue.addOperation(block2)
    }
    
    func operationDependenciesCheck() {
        let operationQueue = OperationQueue()
        let block1 = BlockOperation()
        let block2 = BlockOperation {
            for val in 0...5 {
                print("block2 -> \(val)")
            }
        }
        
        block1.addExecutionBlock {
            for val in 0...5 {
                print("block1 -> \(val)")
            }
        }
        
        //        operationQueue.maxConcurrentOperationCount = 1
        block2.addDependency(block1)
        
        operationQueue.addOperation(block1)
        operationQueue.addOperation(block2)
    }
    
    //    Dispatch Group Implementation Using Operations Queue
    func dispatchGroupImplementationUsingOperationQueue() {
        
        let queue = OperationQueue()
        
        let blockOperation1 = BlockOperation {
            for val in 0...5 {
                print("blockOperation1 --> \(val)")
            }
            print("blockOperation1 * \(Thread.isMainThread)")
        }
        
        let blockOperation2 = BlockOperation {
            for val in 0...5 {
                print("blockOperation2 --> \(val)")
            }
            print("blockOperation2 * \(Thread.isMainThread)")
        }
        
        let blockOperation3 = BlockOperation {
            for val in 0...5 {
                print("blockOperation3 --> \(val)")
            }
            print("blockOperation3 * \(Thread.isMainThread)")
        }
        
        let blockOperation4 = BlockOperation {
            print("All 3 operations completed")
        }
        
        blockOperation4.addDependency(blockOperation3)
        blockOperation4.addDependency(blockOperation2)
        blockOperation4.addDependency(blockOperation1)
        
        //        queue.addOperation(blockOperation1, blockOperation2, blockOperation3, blockOperation4)
        queue.addOperations([blockOperation1, blockOperation2, blockOperation3, blockOperation4], waitUntilFinished: false)
        print("waitUntilFinished")
    }
    
    func cancellingOperation1() {
        let queue = OperationQueue()

        let operation = BlockOperation {
            for i in 1...5 {
                if Thread().isCancelled {
                    print("thread cancelled")
//                    return
                } // Check cancellation
                print("Executing task \(i)")
                sleep(1) // Simulating work
            }
        }

        queue.addOperation(operation)

        // Cancel the operation after 2 seconds
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            operation.cancel()
        }
        print("Last")
    }
    
    func cancellingOperation2() {
        let queue = OperationQueue()

        queue.maxConcurrentOperationCount = 1
        
        let operation1 = BlockOperation {
            for i in 1...5 {
                if Thread().isCancelled {
                    print("thread cancelled")
//                    return
                } // Check cancellation
                print("Executing task operation1 -> \(i)")
                sleep(1) // Simulating work
            }
        }
        
        let operation2 = BlockOperation {
            for i in 1...5 {
                if Thread().isCancelled {
                    print("thread cancelled")
//                    return
                } // Check cancellation
                print("Executing task operation2 -> \(i)")
                sleep(1) // Simulating work
            }
        }

        queue.addOperations([operation1, operation2], waitUntilFinished: false)

        // Cancel the operation after 2 seconds
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            operation2.cancel()
        }
        print("Last")

    }
}
