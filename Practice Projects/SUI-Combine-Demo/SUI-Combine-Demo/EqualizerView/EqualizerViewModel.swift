//
//  EqualizerViewModel.swift
//  SUI-Combine-Demo
//
//  Created by NAGARAJAN, VIJAY (V.) on 2/24/25.
//

import Foundation
import Combine

class EqualizerViewModel: ObservableObject {
    
    
    @Published var showAdjustEqualizerView: Bool = false
    
    @Published var soundTypeValue: String = ""
    
    @Published var bassValue: String = ""
    @Published var middleValue: String = ""
    @Published var trebleValue: String = ""
    
    var equalizerViewInstance: EqualizerControlView = EqualizerControlView()
    var cancellables = Set<AnyCancellable>()
    
    
    init() {
        equalizerBottomSheetObservables()
    }
    
    func equalizerBottomSheetObservables() {
        equalizerViewInstance.soundTypePassthroughSubject
            .sink { value in
                self.soundTypeValue = value
            }
            .store(in: &cancellables)
        
        equalizerViewInstance.bassLevelCurrentValueSubject
            .sink { value in
                self.bassValue = String(format: "%.1f", value)
            }
            .store(in: &cancellables)
        
        equalizerViewInstance.middleLevelCurrentValueSubject
            .sink { completion in
                switch completion {
                case .finished:
                    print("Middle level subject completion finished")
                case .failure(let err):
                    print("Middle level subject failed due to:\(err)")
                }
            } receiveValue: { value in
                self.middleValue = String(format: "%.1f", value)
            }
            .store(in: &cancellables)
        
        equalizerViewInstance.trebleLevelCurrentValueSubject
            .sink { value in
                self.trebleValue = String(format: "%.1f", value)
            }
            .store(in: &cancellables)
    }
}
