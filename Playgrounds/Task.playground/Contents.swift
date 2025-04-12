import UIKit
import SwiftUI

var greeting = "Hello, playground"

/*
 
 
 Task in Swift Concurrency 🚀
 🔹 What is Task?
 Task is part of Swift’s structured concurrency (introduced in Swift 5.5) that allows you to create asynchronous work that runs concurrently.
 
 ✅ Used for launching asynchronous functions in Swift
 ✅ Runs outside the main thread by default
 ✅ Supports cancellation
 ✅ Automatically manages memory and execution
 
 1️⃣ Basic Usage of Task
 A Task runs asynchronously without blocking the main thread.
 
 */


//MARK: - Type 1
//1️⃣ Basic Usage of Task

//Task {
//    print("Start")
//       try await Task.sleep(nanoseconds: 2 * 1_000_000_000)
//    // try await Task.sleep(nanoseconds: 2_000_000_000)
//    // 1000000000 is equal to 1 sec
//    print("End")
//}

//MARK: - Type 2

//Task {
//    for iValue in 0...10 {
//        print("A: \(iValue)")
//    }
//    
//    for iValue in 0...10 {
//        print("B: \(iValue)")
//    }
//    
//    for iValue in 0...10 {
//        print("C: \(iValue)")
//    }
//}


//MARK: - 2️⃣ Calling async Functions with Task

//Type 1
//func fetchData1() async throws -> String {
//    print("fetch started1")
//    try await Task.sleep(nanoseconds: 2 * 1000000000)
//    return "fetchData1 successfully..."
//}
//
//Task {
//   let userResponse1 = try await fetchData1()
//    print("userResponse1--> \(userResponse1)")
//}
//
//func fetchUserData2() async -> String {
//    print("fetch started2")
//    try? await Task.sleep(nanoseconds: 2 * 1000000000)
//    return "fetchData2 successfully..."
//}
//
//Task {
//    let userResponse2 = await fetchUserData2()
//    print("userResponse2-->\(userResponse2)")
//}

//Output:
//fetch started1
//fetch started2
//userResponse1--> fetchData1 successfully...
//userResponse2-->fetchData2 successfully...

//Type 2
//func fetchData1() async throws -> String {
//    print("fetch started1")
//    try await Task.sleep(nanoseconds: 2 * 1000000000)
//    return "fetchData1 successfully..."
//}
//
//func fetchUserData2() async -> String {
//    print("fetch started2")
//    try? await Task.sleep(nanoseconds: 2 * 1000000000)
//    return "fetchData2 successfully..."
//}
//
//Task {
//    let userResponse1 = try await fetchData1()
//     print("userResponse1--> \(userResponse1)")
//    
//    let userResponse2 = await fetchUserData2()
//    print("userResponse2-->\(userResponse2)")
//}

//Output:
//fetch started1
//userResponse1--> fetchData1 successfully...
//fetch started2
//userResponse2-->fetchData2 successfully...



//MARK: - 3️⃣ Task Priority (.high, .background)

//Task(priority: .low) {
//    print("Task priority low - 1")
//}
//
//Task(priority: .medium) {
//    print("Task priority high - 2")
//}
//
//Task(priority: .background) {
//    print("Task priority high - 3")
//}
//
//Task(priority: .high) {
//    print("Task priority high - 4")
//}
//
//Task(priority: .userInitiated) {
//    print("Task priority high - 5")
//}
//
//Task(priority: .utility) {
//    print("Task priority high - 6")
//}



//MARK: - 5️⃣ Cancelling a Task (task.cancel())

let task = Task {
    for i in 1...5 {
        print("Processing \(i)")
        try await Task.sleep(nanoseconds: 1_000_000_000)
        
        if Task.isCancelled {
            print("Task was cancelled")
            return
        }
    }
}

Task {
    try await Task.sleep(nanoseconds: 2_000_000_000)
    task.cancel()  // Cancels the running task
}

//MARK: - 6️⃣ TaskGroup – Running Multiple Tasks Concurrently


