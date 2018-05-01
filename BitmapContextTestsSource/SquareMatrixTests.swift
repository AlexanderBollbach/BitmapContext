//
//  SquareMatrixTests.swift
//  BitmapContextTests
//
//  Created by Alexander Bollbach on 4/29/18.
//  Copyright © 2018 Bollbach, Alexander. All rights reserved.
//

import XCTest
@testable import BitmapContext

class SquareMatrixTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testShouldFailIfNonSquare() {
        
        
        var sut = SquareMatrix(
            with: [
                [1,2,3],
                [1,2,3],
                [1,2,3]
            ]
        )
        
        XCTAssert(sut != nil)
        
        sut = SquareMatrix(
            with: [
                [1,2,3],
                [1,2,3,4,5,6,7,8,9,10],
                [1,2,3]
            ]
        )
        
        XCTAssert(sut == nil)
    }
}
