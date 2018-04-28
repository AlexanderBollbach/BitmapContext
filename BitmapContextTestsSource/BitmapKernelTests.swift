//
//  BitmapKernelTests.swift
//  BitmapContextTests
//
//  Created by Alexander Bollbach on 4/27/18.
//  Copyright © 2018 Bollbach, Alexander. All rights reserved.
//

import XCTest
@testable import BitmapContext

class BitmapKernelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testExample() {
        
        
        let fakeBitmap = FakeBitmap(width: 10, height: 10)
        let bitmapContext = BitmapContext(bitmapTarget: fakeBitmap)
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
