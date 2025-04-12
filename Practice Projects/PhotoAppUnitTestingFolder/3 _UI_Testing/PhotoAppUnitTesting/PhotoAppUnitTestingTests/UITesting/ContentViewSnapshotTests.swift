//
//  ContentViewSnapshotTests.swift
//  PhotoAppUnitTestingTests
//
//  Created by NAGARAJAN, VIJAY (V.) on 11/27/24.
//

import XCTest
import SnapshotTesting
@testable import PhotoAppUnitTesting

final class ContentViewSnapshotTests: XCTestCase {
    
    func test_ContentView_withEnglishTitle() {
        
        // Arrange: Create the view you want to test
        let contentView = ContentView(title: "Test English Title")
        
        // Act & Assert: Take a snapshot and compare it with the reference
        //        assertSnapshots(of: <#T##() -> Value#>, as: <#T##[Snapshotting<Value, Format>]#>, record: <#T##Bool?#>, timeout: <#T##TimeInterval#>, fileID: <#T##StaticString#>, file: <#T##StaticString#>, testName: <#T##String#>, line: <#T##UInt#>, column: <#T##UInt#>)
        
        assertSnapshots(
            of: contentView,
            as: [
                "iPhone": Snapshotting.image(layout: .device(config: .iPhoneX)),
                "iPad": Snapshotting.image(layout: .device(config: .iPadPro12_9))
            ],
            record: false, // Set to true if you need to record a new reference snapshot
            timeout: 5.0
        )
    }
    
    func test_SignupView_Reference() {
        
        // Arrange
        let signupView = SignupView()
        
        // Act & Assert
//        assertSnapshots(of: <#T##Value#>, as: <#T##[String : Snapshotting<Value, Format>]#>)
        assertSnapshots(of: signupView, as: [
            "iPhone": Snapshotting.image(layout: .device(config: .iPhoneX))
        ])
    }
    
    
}


/*
 
 https://medium.com/cstech/ui-test-automation-snapshot-testing-in-ios-bd8bcb595cf8
 
 Reference Youtube video link for point free snapshot test:
 https://www.youtube.com/watch?v=DqW2cb6JLRQ
 */


