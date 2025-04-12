import UIKit
import SwiftUI

var greeting = "Hello, playground"

//MARK: - Type 1 Actor

actor BankAccount {
    var balance: Int = 0
    
    func deposit(amount: Int) {
        balance += amount
    }
    
    func getBalance() -> Int {
        return balance
    }
}

let account = BankAccount()

Task {
    await account.deposit(amount: 10)
    await account.deposit(amount: 10)
    await account.deposit(amount: 10)
    print("\(await account.getBalance())")
    await account.deposit(amount: 10)
    await account.deposit(amount: 10)
    print("\(await account.getBalance())")
}





//MARK: - Type 2

//class HDFCBankAccount {
//    var balance: Int = 0
//
//}
//
//let hdfcBank = HDFCBankAccount()
//DispatchQueue.concurrentPerform(iterations: 100) { _ in
//    hdfcBank.balance += 1
//}


//MARK: - Type 3

actor SafeBankAccount {
    var balance: Int = 0
    
    func deposit(amount: Int) {
        balance += amount
    }
}

let safeBank = SafeBankAccount()


DispatchQueue.concurrentPerform(iterations: 10) { value in
    print("value-->\(value)")
    Task {
        await safeBank.deposit(amount: value)
    }
}


//MARK: - @MainActor

@MainActor
class ViewModel: ObservableObject {
    @Published var userName: String = ""
    
    func fetchUser() async throws {
        try await Task.sleep(nanoseconds: 2 * 100000)
        userName = "Thor"
    }
    
    func fetchUser1() async {
        do {
            try await Task.sleep(nanoseconds: 2 * 100000)
            userName = "Captain America"
        } catch let err {
            print(err)
        }
//         await Task.sleep(nanoseconds: 2 * 100000)
        userName = "Thor"
    }
}

struct UserView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            Text("\(viewModel.userName)")
            
            Button("Fetch user") {
                Task {
                   try await viewModel.fetchUser()
                   await viewModel.fetchUser1()
                }
            }
        }
    }
}
