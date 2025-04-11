//
//  ActorIsolationCheckView.swift
//  VJConcurrencyDemo
//
//  Created by NAGARAJAN, VIJAY (V.) on 16/10/24.
//

import Foundation
import SwiftUI

struct ActorIsolationCheckView: View {
    @State var amountNeeded: String

    var body: some View {
        NavigationStack {
            VStack(alignment: .center, spacing: 20) {
                
                Text("Balance withdraw from HDFC account")
                TextField("Enter Amount Needed", text: $amountNeeded)
                    .multilineTextAlignment(.center)
                
                Button {
                    Task {
                        await amountWithdrawType()
                    }
                } label: {
                    Text("Withdraw")
                }

            }
            .padding(50)
        }
        
        
    }
    
    func amountWithdrawType() async {
       await hdfcBankFlow()
    }
    
    func hdfcBankFlow() async {
        let elaAccount: HDFCBank = .init(accountHolder: "Ela", accountNo: 0987654321, balance: Int(amountNeeded) ?? 0)
        await elaAccount.withdraw(amount: 1)
        await elaAccount.withdraw(amount: 1)
        await elaAccount.withdraw(amount: 1)
        await elaAccount.withdraw(amount: 1)
        await elaAccount.withdraw(amount: 1)
        
        elaAccount.description
        elaAccount.accountdetails
    }
    
}

actor HDFCBank {
    let accountHolder: String
    let accountNo: Int
    
    var balance: Int
    
    nonisolated var accountdetails: String {
        "Account holder name: \(accountHolder), AccountNo: \(accountNo)"
    }
    
    
    init(accountHolder: String, accountNo: Int, balance: Int) {
        self.accountHolder = accountHolder
        self.accountNo = accountNo
        self.balance = balance
    }
    
    func withdraw(amount: Int) async {
        guard balance >= amount else {
            print("Insufficient balance in HDFCBank")
            return
        }
        do {
            try await Task.sleep(nanoseconds: 3000000000)
        } catch {
            print("error-->\(error)")
        }
        
        
        print("HDFC before balance - \(balance)")
        balance -= amount
        print("HDFC after balance - \(balance)")
    }
}

//extension HDFCBank: @preconcurrency CustomStringConvertible {
//    var description: String {
//        "Account holder name: \(accountHolder), AccountNo: \(accountNo)"
//    }
//}

extension HDFCBank: CustomStringConvertible {
    nonisolated var description: String {
        "Account holder name: \(accountHolder), AccountNo: \(accountNo)"
    }
}

//extension HDFCBank: CustomStringConvertible {
//    nonisolated var description: String {
//        "Account holder name: \(accountHolder), AccountNo: \(accountNo), balance: \(balance)"
//    }
//}
