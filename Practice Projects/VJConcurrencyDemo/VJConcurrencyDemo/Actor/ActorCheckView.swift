//
//  ActorCheckView.swift
//  VJConcurrencyDemo
//
//  Created by NAGARAJAN, VIJAY (V.) on 11/09/24.
//

import SwiftUI

struct ActorCheckView: View {
    @State var amountNeeded: String
    var body: some View {
        NavigationStack {
            VStack(alignment: .center, spacing: 20) {
                
                Text("Balance withdraw from account")
                TextField("Enter Amount Needed", text: $amountNeeded)
                    .multilineTextAlignment(.center)
                
                Button {
                    //                amountWithdrawType()
                    Task {
                        await amountWithdrawType()
                    }
                    
                } label: {
                    Text("Withdraw")
                }
                
                NavigationLink("Cross-Actor reference") {
                    CrossActorReferenceView(amount: amountNeeded)
                }
            }
            .padding(50)
        }
        
        
    }
    
    func amountWithdrawType() async {
        let type: WithDrawType = .withQueue
        switch type {
        case .directWithoutQueue:
            directWithoutQueueFunc()
            break
        case .withQueue:
            withQueueFunc()
            break
        case .withLock:
            withLockFunc()
            break
        case .withActor:
            await withActorFunc()
            break
        }
    }
    
    func directWithoutQueueFunc() {
        
        // Single shared resource accessed from multiple 3 threads
        // ‘Race Condition.’ A race condition occurs when multiple threads simultaneously access and modify a shared resource
        let account = Account1()
        
        DispatchQueue.global().async {
            account.withdraw(amount: Int(amountNeeded) ?? 0)
        }
        DispatchQueue.global().async {
            account.withdraw(amount: Int(amountNeeded) ?? 0)
        }
        DispatchQueue.global().async {
            account.withdraw(amount: Int(amountNeeded) ?? 0)
        }
        
        //        DispatchQueue.global().async {
        //            account.withdraw(amount: Int(amountNeeded) ?? 0)
        //            account.withdraw(amount: Int(amountNeeded) ?? 0)
        //            account.withdraw(amount: Int(amountNeeded) ?? 0)
        //        }
        
    }
    
    func withQueueFunc() {
        let account = Account2()
        
//        DispatchQueue.global().async {
//            account.withdraw(amount: Int(amountNeeded) ?? 0)
//        }
//        DispatchQueue.global().async {
//            account.withdraw(amount: Int(amountNeeded) ?? 0)
//        }
//        DispatchQueue.global().async {
//            account.withdraw(amount: Int(amountNeeded) ?? 0)
//        }
        
        DispatchQueue.global().async {
            account.withdraw(amount: 1)
        }
        DispatchQueue.global().async {
            account.withdraw(amount: 2)
        }
        DispatchQueue.global().async {
            account.withdraw(amount: 3)
        }
        DispatchQueue.global().async {
            account.withdraw(amount: 4)
        }
        DispatchQueue.global().async {
            account.withdraw(amount: 5)
        }
        
//        DispatchQueue.global().async {
//            account.withdraw(amount: 1)
//            account.withdraw(amount: 2)
//            account.withdraw(amount: 3)
//            account.withdraw(amount: 4)
//            account.withdraw(amount: 5)
//        }
        
    }
    
    func withLockFunc() {
        let account = Account3()
//       let temp = threadpo
//        DispatchQueue.main
        DispatchQueue.global().async {
            account.withdraw(amount: Int(amountNeeded) ?? 0)
        }
        DispatchQueue.global().async {
            account.withdraw(amount: Int(amountNeeded) ?? 0)
        }
        DispatchQueue.global().async {
            account.withdraw(amount: Int(amountNeeded) ?? 0)
        }
    }
    
    func withActorFunc() async {
        let account = Account4()
        let accNo = account.accountNumber
        
        //        await account.balance = 50
       let temp = account.accountNumber
        let temp1 = await account.balance
       let temp2 = account.balancevvvv
        
        await account.withdraw(amount: Int(amountNeeded) ?? 0)
        await account.withdraw(amount: Int(amountNeeded) ?? 0)
        
        await account.withdraw(amount: Int(amountNeeded) ?? 0)
    }
    
}

#Preview {
    ActorCheckView(amountNeeded: "20")
}


/*
 https://medium.com/@valentinjahanmanesh/swift-actors-in-depth-19c8b3dbd85a#:~:text=What%20is%20an%20actor%3F,state%20in%20concurrent%20programming%20environments.
 
 Actor:
 What is an actor?
 In Swift, an actor is a reference type
 introduced in Swift 5.5 as part of its advanced concurrency model.
 Its primary role is to prevent data races and ensure safe access to shared mutable state in concurrent programming environments.
 */


/*
 Each time the execution happens, will provide a different kind of responses.
 before balance - 20
 after balance - 0
 before balance - 20
 after balance - -20
 before balance - 20
 after balance - -40
 
 
 before balance - 20
 after balance - 0
 before balance - 20
 after balance - -20
 before balance - 20
 after balance - -40
 
 
 before balance - 20
 after balance - 0
 Insufficient balance
 Insufficient balance
 
 before balance - 20
 after balance - 0
 before balance - 20
 after balance - -20
 Insufficient balance
 */
