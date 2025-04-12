//
//  CustomOperationView.swift
//  ConcurrencyByTutorialsVJ
//
//  Created by Vijay N on 31/03/25.
//

import SwiftUI
import Foundation

struct CustomOperationView: View {
    
    let viewModel = CustomOperationViewModel()
    
    var body: some View {
        Button("Custom Operation Check") {
            viewModel.customOperationCheck()
        }
    }
}

#Preview {
    CustomOperationView()
}

class CustomOperationViewModel {
    
    func customOperationCheck() {
        let operationQueue = OperationQueue()

        let myOperation = MyOperation()
        operationQueue.addOperation(myOperation)
        
        let anotherBlockOperation = BlockOperation {
            print("Another block operation")
        }
        operationQueue.addOperation(anotherBlockOperation)
    }
}


class MyOperation: Operation {
    override func main() {
        if isCancelled {
            return
        }
        
        // Your task here
        print("Task is running")
        
        if isCancelled {
            return
        }
        
        // More task logic if needed
    }
}
