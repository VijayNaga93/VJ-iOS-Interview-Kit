//
//  GCDandOperationsView.swift
//  ConcurrencyByTutorialsVJ
//
//  Created by Vijay N on 27/03/25.
//

import SwiftUI

struct GCDandOperationsView: View {
    
    let viewModel = GCDandOperationsViewModel()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        Button("GCD variation check") {
            viewModel.mainThreadBlockTimeCheck()
        }
    }
    
}

#Preview {
    GCDandOperationsView()
}

class GCDandOperationsViewModel {
    
    func mainThreadBlockTimeCheck() {
        let startTime = CFAbsoluteTimeGetCurrent()
        
        DispatchQueue.global().async {
            for val in 0...50000 {
                print("### -> \(val)")
            }
        }
        
        DispatchQueue.global().async {
            for val in 0...50000 {
                print("&&& -> \(val)")
            }
        }
        
        print("Main thread stopped duration \(CFAbsoluteTimeGetCurrent() - startTime)")
        /*
         sync - Main thread stopped duration  6.584749937057495
         async - Main thread stopped duration 9.500980377197266e-05
         */
        
    }
    
    func dispatchQueueCheck1() {
        let serialQueue1 = DispatchQueue(label: "com.test.squeue1")
        serialQueue1.async {
            DispatchQueue.main.async {
                
            }
        }
        
        let concurrentQueue1 = DispatchQueue(label: "com.test.cqueue1", attributes: .concurrent)
        concurrentQueue1.async {
            
        }
        
        let qosSerialCheck = DispatchQueue(label: "com.test.qosSerial", qos: .userInitiated)
        qosSerialCheck.async {
            
        }
        
        let qosConcurrentCheck = DispatchQueue(label: "com.test.qosConcurrent", qos: .utility, attributes: .concurrent)
        qosConcurrentCheck.async {
            
        }
        
        let globalQueue1 = DispatchQueue.global(qos: .userInitiated)
        globalQueue1.async {
            
        }
        
        let globalQueue2 = DispatchQueue.global()
        globalQueue2.async {
            
        }
    }
}
