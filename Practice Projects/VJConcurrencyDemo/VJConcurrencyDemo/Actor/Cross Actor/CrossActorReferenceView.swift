//
//  CrossActorReferenceView.swift
//  VJConcurrencyDemo
//
//  Created by NAGARAJAN, VIJAY (V.) on 11/09/24.
//

import SwiftUI

struct CrossActorReferenceView: View {
    @State var amount: String
    var body: some View {
        VStack {
            TextField("Enter amount to withdraw", text: $amount)
            
            Button(action: {
                Task {
                    await withdrawFromTransactionManager(withdrawAmount: Int(amount) ?? 0)
                }
            }, label: {
                Text("Withdraw")
            })
        }
        .padding(50)
    }
    
    func withdrawFromTransactionManager(withdrawAmount: Int) async {
        let jointAccount = JointAccount1()
        let transactionManager = TransactionManager(account: jointAccount)
        
        // Perform a withdrawal from TransactionManager Actor
        await transactionManager.performWithdrawal(amount: withdrawAmount)

        // Perform a withdrawal from outside any actor
        await jointAccount.withdraw(amount: withdrawAmount)
        
    }
}

#Preview {
    CrossActorReferenceView(amount: "10")
}

actor JointAccount1 {
    var balance: Int = 20
    
    func withdraw(amount: Int) {
        guard balance >= amount else { return print("Insufficient Balance JointAccount1") }
        print("JA1 before balance - \(balance)")
        balance -= amount
        print("JA1 after balance - \(balance)")
    }
}

actor TransactionManager {
    var account: JointAccount1
    
    init(account: JointAccount1) {
        self.account = account
    }
    
    func performWithdrawal(amount: Int) async {
        await account.withdraw(amount: amount)
    }
}

