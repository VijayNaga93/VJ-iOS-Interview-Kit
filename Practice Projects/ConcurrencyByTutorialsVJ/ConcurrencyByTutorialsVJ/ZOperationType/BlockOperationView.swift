//
//  BlockOperationView.swift
//  ConcurrencyByTutorialsVJ
//
//  Created by Vijay N on 28/03/25.
//

import SwiftUI

struct BlockOperationView: View {
    let viewModel = BlockOperationViewModel()
    
    var body: some View {
        
        Button("BlockOperation Check") {
            viewModel.blockOperationCheck()
        }
    }
}

#Preview {
    BlockOperationView()
}


class BlockOperationViewModel {
    
    func blockOperationCheck() {
        let operation1 = BlockOperation {
            print("operation")
        }
        operation1.start()
        
        
        let operation2 = BlockOperation()
        let sentence = "Thor is the strongest avenger"
        
        for value in sentence.components(separatedBy: " ") {
            operation2.addExecutionBlock {
                print(value)
                print(Thread.current.name ?? "")
                print(Thread().isMainThread)
                sleep(2)
                
            }
        }
        operation2.completionBlock = {
            print("operation 2 completed")
        }
        operation2.start()
     
        // Operation objects execute in a synchronous manner by default — that is, they perform their task in the thread that calls their start method.
    
        let operation3 = BlockOperation {
            for val in 0...10 {
                print("operation3 -> \(val)")
                print(Thread.isMainThread)
                
            }
        }
        
        // called in main thread
        operation3.start()
        

        DispatchQueue.global().async {
            
            let operation4 = BlockOperation {
                for val in 0...10 {
                    print("operation4 -> \(val)")
                    print(Thread.isMainThread)
                    
                }
            }
            // called in background thread
            operation4.start()
        }
    }

}
