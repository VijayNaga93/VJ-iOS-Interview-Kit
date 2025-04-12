//
//  DispatchWorkItemView.swift
//  ConcurrencyByTutorialsVJ
//
//  Created by Vijay N on 28/03/25.
//

import SwiftUI

struct DispatchWorkItemView: View {
    let viewModel = DispatchWorkItemViewModel()
    
    var body: some View {
        Button("dispatchWorkItem Check") {
            viewModel.dispatchWorkItemCheck()
        }
    }
}

#Preview {
    DispatchWorkItemView()
}

class DispatchWorkItemViewModel {
    
    func dispatchWorkItemCheck() {
        
        let queue = DispatchQueue(label: "com.test.check1")
        let workItem = DispatchWorkItem {
            print("workItem check")
        }
        
        
        
        queue.async(execute: workItem)
        
        queue.asyncAfter(deadline: DispatchTime.now() + 1, execute: workItem)
        
        
        
        queue.async(execute: workItem)
//        workItem.perform()
        
        if workItem.isCancelled {
            print("work item cancelled")
        }
        
        workItem.cancel()

    }
}
