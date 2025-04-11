//
//  EqualizerControlView.swift
//  SUI-Combine-Demo
//
//  Created by NAGARAJAN, VIJAY (V.) on 2/24/25.
//

import SwiftUI
import Combine

struct EqualizerControlView: View {
    @State var soundType: String = "Pop"
    var soundTypeArr: [String] = ["Rock", "Jazz", "Hip - Hop", "Pop"]
    
    @State var bassValue: Float = 0.5
    @State var middleValue: Float = 0.5
    @State var trebleValue: Float = 0.5
    
    let soundTypePassthroughSubject = PassthroughSubject<String, Never>()
    let bassLevelCurrentValueSubject = CurrentValueSubject<Float, Never>(0.5)
    let middleLevelCurrentValueSubject = CurrentValueSubject<Float, Never>(0.3)
    let trebleLevelCurrentValueSubject = CurrentValueSubject<Float, Never>(0.7)
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Equalizer")
                .font(.title)
            
            Picker("Sound Type", selection: $soundType) {
                ForEach(soundTypeArr, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.segmented)
            .onChange(of: soundType) { oldValue, newValue in
                print("\(oldValue) --- \(newValue)")
                soundTypePassthroughSubject.send(newValue)
            }
            
            
            HStack(spacing: 10) {
                Text("Bass")
                Slider(value: $bassValue, in: 0.0...1.0)
                    .onChange(of: bassValue) { oldValue, newValue in
                        bassLevelCurrentValueSubject.send(newValue)
                    }
            }
            
            HStack(spacing: 10) {
                Text("Middle")
                Slider(value: $middleValue, in: 0.0...1.0)
                    .onChange(of: middleValue) { oldValue, newValue in
                        middleLevelCurrentValueSubject.send(newValue)
                    }
            }
            
            HStack(spacing: 10) {
                Text("Treble")
                Slider(value: $trebleValue, in: 0.0...1.0)
                    .onChange(of: trebleValue) { oldValue, newValue in
                        trebleLevelCurrentValueSubject.send(trebleValue)
                    }
            }
        }
        .padding(.horizontal, 30)
    }
}

#Preview {
    EqualizerControlView()
}

