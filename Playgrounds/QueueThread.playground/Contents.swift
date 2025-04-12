import UIKit
import Foundation

var greeting = "Hello, playground"


//let serialQueue = DispatchQueue(label: "com.example.serialQueue")
//
//serialQueue.async {
//    print("Task 1 on Start \(Thread.current)")
////   async Task.sleep(nanoseconds: 2 * 100000)
//    Thread.sleep(forTimeInterval: 3)
//    print("Task 1 on Finish \(Thread.current)")
//}
//serialQueue.sync {
//    print("Task 2 on Start \(Thread.current)")
//    print("Task 2 on Finish \(Thread.current)")
//}

/*
 Task 1 on Start <_NSMainThread: 0x600001700040>{number = 1, name = main}
 Task 1 on Finish <_NSMainThread: 0x600001700040>{number = 1, name = main}
 Task 2 on Start <_NSMainThread: 0x600001700040>{number = 1, name = main}
 Task 2 on Finish <_NSMainThread: 0x600001700040>{number = 1, name = main}
 */





let concurrentQueue = DispatchQueue(label: "com.example.serialQueue", attributes: .concurrent)



concurrentQueue.sync {
    print("Task 1 on Start \(Thread.current)")
//   async Task.sleep(nanoseconds: 2 * 100000)
    Thread.sleep(forTimeInterval: 3)
    print("Task 1 on Finish \(Thread.current)")
}
concurrentQueue.sync {
    print("Task 2 on Start \(Thread.current)")
    print("Task 2 on Finish \(Thread.current)")
}





/*
 Task 1 on Start <NSThread: 0x600001728840>{number = 5, name = (null)}
 Task 2 on Start <NSThread: 0x600001706a80>{number = 9, name = (null)}
 Task 2 on Finish <NSThread: 0x600001706a80>{number = 9, name = (null)}
 Task 1 on Finish <NSThread: 0x600001728840>{number = 5, name = (null)}
 */
