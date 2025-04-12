//
//  GroupsandSemaphoresView.swift
//  ConcurrencyByTutorialsVJ
//
//  Created by Vijay N on 27/03/25.
//

import SwiftUI

struct GroupsandSemaphoresView: View {
    
    let viewModel = GroupsandSemaphoresViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            ProgressView()
                .progressViewStyle(.automatic)
                .frame(width: 100, height: 100, alignment: .center)
                .background(.yellow)
            
            Button("dispatchGroupCheck") {
                viewModel.dispatchGroupCheck()
            }
            
            Button("Synchronous waiting Check") {
                viewModel.synchronousWaitingCheck()
            }
            
            Button("wrappingAsynchronousMethod Check") {
                viewModel.wrappingAsynchronousMethod()
            }
            
            Button("semaphores Check") {
                viewModel.semaphoresCheck()
            }
            
        }
        
    }
}

#Preview {
    GroupsandSemaphoresView()
}

class GroupsandSemaphoresViewModel {
    
    func dispatchGroupCheck() {
        let group = DispatchGroup()
        
        
        let queue1 = DispatchQueue(label: "c1")
        let queue2 = DispatchQueue(label: "c2")
        let queue3 = DispatchQueue(label: "c3")
        
        queue1.async(group: group, qos: .utility) {
            for val in 0...10 {
                print("queue11-->\(val)")
            }
            //            for val in 0...10 {
            //                print("queue111-->\(val)")
            //            }
            //            for val in 0...10 {
            //                print("queue1111-->\(val)")
            //            }
        }
        
        queue2.async(group: group) {
            for val in 0...50000 {
                print("queue2-->\(val)")
            }
        }
        
        queue3.async(group: group, qos: .userInitiated) {
            for val in 0...10 {
                print("queue3-->\(val)")
            }
        }
        
        group.notify(queue: .main) {
            print("Group completed")
        }
        
        //        Synchronous waiting
        if group.wait(timeout: .now() + 3) == .timedOut {
            print("The jobs didn't finish in 5 seconds")
        }
        
        queue3.async(group: group, qos: .userInitiated) {
            for val in 0...10 {
                print("queue4-->\(val)")
            }
        }
        
    }
    
    func synchronousWaitingCheck() {
        let group = DispatchGroup()
        let queue = DispatchQueue.global(qos: .userInitiated)
        
        queue.async(group: group) {
            print("task 1 started")
            Thread.sleep(forTimeInterval: 10)
            print("task 1 ended")
        }
        
        queue.async(group: group) {
            print("task 2 started")
            Thread.sleep(forTimeInterval: 2)
            print("task 2 ended")
        }
        
        if group.wait(timeout: .now() + 5) == .timedOut {
            print("I got tired of waiting")
        } else {
            print("All the jobs have completed")
        }
        
        group.notify(queue: .main) {
            print("group notified")
        }
    }
    
    func wrappingAsynchronousMethod() {
        let group = DispatchGroup()
        let queue = DispatchQueue.global()
        queue.async(group: group) {
            
            group.enter()
            DispatchQueue.global().async {
                defer {
                    group.leave()
                }
                print("task 1 started")
                Thread.sleep(forTimeInterval: 5)
                print("task 1 ended")
            }
            
            group.enter()
            DispatchQueue.global().async {
                defer {
                    group.leave()
                }
                print("task 2 started")
                Thread.sleep(forTimeInterval: 2)
                print("task 2 ended")
            }
        }
        
        group.notify(queue: .global()) {
            print("group completion notified")
        }
    }
    
    func semaphoresCheck() {
        
        let semaphore = DispatchSemaphore(value: 3) // Allow 3 simultaneous downloads
        let queue = DispatchQueue.global(qos: .background)

        for i in 1...10 {
            queue.async {
                semaphore.wait() // Wait for permission to download
                print("Downloading image \(i)...")
                Thread.sleep(forTimeInterval: TimeInterval(2)) // Simulate a download
                print("Downloaded image \(i)")
                semaphore.signal() // Notify that the download is complete
            }
        }
    }
    
}
