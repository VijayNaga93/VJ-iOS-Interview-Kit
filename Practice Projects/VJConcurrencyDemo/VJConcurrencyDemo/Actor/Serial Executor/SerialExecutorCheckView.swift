//
//  SerialExecutorCheckView.swift
//  VJConcurrencyDemo
//
//  Created by NAGARAJAN, VIJAY (V.) on 13/09/24.
//

import SwiftUI

struct SerialExecutorCheckView: View {
    var body: some View {
        VStack(spacing: 30) {
            Button(action: {
                Task {
                    await serialExecutorTest()
                }
            }, label: {
                Text("SerialExecutor")
            })
            
            Button(action: {
                
            }, label: {
                Text("Serial Dispatch Queue")
            })
        }
    }
    
    func serialExecutorTest() async {
        let actor = SerialExecutorActor()
        //Call to actor-isolated instance method 'printTheGiven(givenStr:)' in a synchronous nonisolated context
        for i in 1...10 {
            await actor.printTheGiven(givenStr: "\(i)")
        }
        
        for i in 11...20 {
            await actor.printTheGiven(givenStr: "\(i)")
        }
        
        for i in 21...30 {
            await actor.printTheGiven(givenStr: "\(i)")
        }

    }
}

#Preview {
    SerialExecutorCheckView()
}


actor SerialExecutorActor {
    func printTheGiven(givenStr: String) {
        print("givenStr-->\(givenStr)")
    }
}
