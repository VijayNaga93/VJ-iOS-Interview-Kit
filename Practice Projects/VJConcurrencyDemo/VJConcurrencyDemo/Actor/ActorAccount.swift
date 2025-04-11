//
//  ActorAccount.swift
//  VJConcurrencyDemo
//
//  Created by NAGARAJAN, VIJAY (V.) on 20/08/24.
//

import Foundation
import UIKit

enum WithDrawType {
    case directWithoutQueue
    case withQueue
    case withLock
    case withActor
}

class Account1 {
    var balance: Int = 20
    
    func withdraw(amount: Int) {
        guard balance >= amount else { return print("Insufficient balance A1") }
        
        print("A1 before balance - \(balance)")
        balance -= amount
        print("A1 after balance - \(balance)")
    }
}



class Account22 {
    // A serial dispatch queue ensures that only one task runs at a time, making it an easy way to synchronize access to shared resources.
    
    private var balance: Int = 20
    private var queue = DispatchQueue(label: "com.example.accountQueue")
//    let tenp = NSOperation
    func withdraw(amount: Int) {
        queue.sync {
            guard balance >= amount else { return print("Insufficient balance A2") }
            print("A2 before balance - \(balance)")
            balance -= amount
            print("A2 after balance - \(balance)")
        }
    }
}

class Account2 {
    // A serial dispatch queue ensures that only one task runs at a time, making it an easy way to synchronize access to shared resources.
    
    private var balance: Int = 20
    private var queue = DispatchQueue.global()
//    private var queue = DispatchQueue(label: "com.example.accountQueue")
//    private var queue = DispatchQueue(label: "com.example.accountQueue", attributes: .concurrent)
//    let tenp = NSOperation
    func withdraw(amount: Int) {
        queue.sync {
            print("A2 amount - \(amount)")
            guard self.balance >= amount else { return print("Insufficient balance A2") }
            print("A2 before balance - \(self.balance)")
            self.balance -= amount
            print("A2 after balance - \(self.balance)")
        }
    }
}


class Account3 {
    //    You can also use a lock to achieve thread safety. The NSLock class is a simple locking mechanism provided by Foundation.
    
    private var balance: Int = 20
    private let lock = NSLock()
    
    func withdraw(amount: Int) {
        lock.lock()
        defer { lock.unlock() }
//        Timer(timeInterval: <#T##TimeInterval#>, repeats: <#T##Bool#>, block: <#T##(Timer) -> Void#>)
        guard balance >= amount else {
            print("Insufficient balance A3")
            return
        }
        print("A3 before balance - \(balance)")
        self.balance = balance - amount
        print("A3 after balance - \(balance)")
    }
}


actor Account4 {
    let accountNumber: String = "ABC123"
    let balancevvvv: Int = 20
    var balance: Int = 20
    
    func withdraw(amount: Int) {
        guard balance >= amount else { return print("Insufficient balance A4") }
        
        print("A4 before balance - \(balance)")
        balance -= amount
        print("A4 after balance - \(balance)")
    }
}














//button
//1000
//label
