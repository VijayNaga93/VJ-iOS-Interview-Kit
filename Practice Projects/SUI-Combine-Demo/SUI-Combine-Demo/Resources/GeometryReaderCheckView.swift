//
//  GeometryReaderCheckView.swift
//  SUI-Combine-Demo
//
//  Created by Vijay on 16/06/25.
//

import SwiftUI

struct GeometryReaderCheckView: View {
    var body: some View {
        ScrollView {
            
            VStack {
                ForEach(0..<10) { i in
                    HStack {
                        GeometryReader { geo in
                            CircleView(cwidth: 100, cheight: 100, ccolor: .blue)
                                .position(x: geo.size.width / 2, y: geo.size.height / 2)
                        }
                        .frame(height: 150)
                        GeometryReader { geo in
                            CircleView(cwidth: 100, cheight: 100, ccolor: .blue)
                                .position(x: geo.size.width / 2, y: geo.size.height / 2)
                        }
                        .frame(height: 150)
                    }
                }
            }
        }
    }
}

#Preview {
    GeometryReaderCheckView()
}

struct CircleView: View {
    var cwidth: CGFloat
    var cheight: CGFloat
    var ccolor: Color
    
    var body: some View {
        Circle()
            .fill(ccolor)
            .frame(width: cwidth, height: cheight, alignment: .center)
    }
}
