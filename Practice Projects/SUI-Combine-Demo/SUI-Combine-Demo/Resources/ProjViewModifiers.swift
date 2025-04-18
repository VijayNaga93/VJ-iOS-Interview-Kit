//
//  ProjViewModifiers.swift
//  SUI-Combine-Demo
//
//  Created by Developer on 13/04/25.
//

import SwiftUI

struct CustomButtonStyle1: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(10)
            .background(.blue)
            .foregroundStyle(.black)
            .cornerRadius(10)
    }
}

struct CustomButtonStyle2: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(10)
            .background(.gray)
            .foregroundStyle(.white)
            .cornerRadius(10)
    }
}


extension View {
    func customButtonStyle1() -> some View {
        self.modifier(CustomButtonStyle1())
    }
    
    func customButtonStyle2() -> some View {
        self.modifier(CustomButtonStyle2())
    }
}
