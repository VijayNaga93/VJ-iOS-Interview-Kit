//
//  ProjViewRepresentables.swift
//  SUI-Combine-Demo
//
//  Created by Vijay on 15/06/25.
//

import SwiftUI
import UIKit

struct ProjViewRepresentablesCheckView: View {
    
    @State var editorText1: String = ""
    @State var editorText2: String = ""
    
    var body: some View {
        VStack {
            TextEditor(text: $editorText1)
                .padding(20)
                .background(Color.yellow)
                .cornerRadius(8)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray))
                .font(.body)
                .frame(height: 100, alignment: .center)
            
            
            //
            
            UITextViewWrapper(text: $editorText2)
                .padding(20)
                .background(Color.blue)
                .cornerRadius(8)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray))
                .font(.body)
                .frame(height: 100, alignment: .center)
            
            
        }
    }
}

#Preview {
    ProjViewRepresentablesCheckView()
}



struct UITextViewWrapper: UIViewRepresentable {
    @Binding var text: String
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 16)
        textView.delegate = context.coordinator
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        if uiView.text != text {
            uiView.text = text
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: UITextViewWrapper
        
        init(_ parent: UITextViewWrapper) {
            self.parent = parent
        }
        
        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
        }
    }
}
