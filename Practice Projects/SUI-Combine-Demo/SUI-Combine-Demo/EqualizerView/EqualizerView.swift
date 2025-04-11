//
//  EqualizerView.swift
//  SUI-Combine-Demo
//
//  Created by NAGARAJAN, VIJAY (V.) on 2/24/25.
//

import SwiftUI

struct EqualizerView: View {
    
    @ObservedObject var viewModel: EqualizerViewModel = EqualizerViewModel()
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                HStack(spacing: 10) {
                    Text("Sound Type : ")
                    Text("\(viewModel.soundTypeValue)")
                }
                
                Text("Bass Level: \(viewModel.bassValue)")
                Text("Middle Level: \(viewModel.middleValue)")
                Text("Treble Level: \(viewModel.trebleValue)")
                
                Button {
                    viewModel.showAdjustEqualizerView.toggle()
                } label: {
                    Text("Adjust Equalizer")
                }
                .sheet(isPresented: $viewModel.showAdjustEqualizerView) {
                    viewModel.equalizerViewInstance
                        .presentationDetents([.medium, .large])
                        .presentationDragIndicator(.visible)
                }
                Spacer()
            }
            .padding(.top, 50)
            .navigationTitle("Equalizer View")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("", systemImage: "xmark") {
                        dismiss()
                    }
                }
            }
        }
    }
    
}

#Preview {
    EqualizerView()
}
