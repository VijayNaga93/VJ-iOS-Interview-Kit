//
//  PassthroughCurrentValueView.swift
//  SUI-Combine-Demo
//
//  Created by Vijay N on 11/04/25.
//

import SwiftUI
import Combine

//MARK: - Subjects, PassthroughSubject, CurrentValueSubject

class PassthroughCurrentValueViewModel: ObservableObject {
    
    // PassthroughSubject
    func checkingPassthroughSubject() {
        /*
         PassthroughSubject<Int, Never>
         PassthroughSubject<Int, Error>
         */
        let subject = PassthroughSubject<Int, Never>()
        
        let cancellable = subject
            .sink { completion in
                print("Completed: \(completion)")
            } receiveValue: { value in
                print("Received value: \(value)")
            }
        
        subject.send(11)
        subject.send(12)
        subject.send(13)
        subject.send(completion: .finished)
        //        subject.send(completion: .failure(<#T##Never#>))
        
        
        let subject2 = PassthroughSubject<Int, Error>()
        
        let cancellable2 = subject2
            .sink { completion in
                switch completion {
                case .finished:
                    print("Completion finished for subject2")
                case let .failure(err):
                    print("Completion error: \(err.localizedDescription)")
                }
            } receiveValue: { value in
                print("Received value: \(value)")
            }
        
        subject2.send(21)
        subject2.send(22)
        
        subject2.send(completion: .finished)
        subject2.send(23)
        subject2.send(completion: .failure(CustomProjError.unknownError))
        
        
    }
    
    // CurrentValueSubject
    func checkingCurrentValueSubject() {
        let currentValueSubject1 = CurrentValueSubject<Int, Never>(11)
        
        let cancellable1 = currentValueSubject1
            .sink { completion in
                print("currentValueSubject1 Completion finished \(completion)")
            } receiveValue: { value in
                print("currentValueSubject1 Received value: \(value)")
            }
        
        currentValueSubject1.send(12)
        currentValueSubject1.send(13)
        
        let currentValueSubject2 = currentValueSubject1
        
        let cancellable2 = currentValueSubject2
            .sink { completion in
                print("currentValueSubject2 Completion finished \(completion)")
            } receiveValue: { value in
                print("currentValueSubject2 Received value: \(value)")
            }
        
        currentValueSubject2.send(14)
        
    }
    
}

struct PassthroughCurrentValueView: View {
    @StateObject var vm = PassthroughCurrentValueViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("User Model List")
                Button {
                    //                    vm.checkingPassthroughSubject()
                    vm.checkingCurrentValueSubject()
                } label: {
                    Text("Fetch User data")
                }
                
                
            }
        }
        .navigationTitle("User Model Titlte")
        
    }
}

#Preview {
    PassthroughCurrentValueView()
}
