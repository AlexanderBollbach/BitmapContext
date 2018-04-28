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
    
    func testAllColorsWhite() {
        
        let context = allWhite_10x10_Bitmap_Fixture()
        
        context.forEachColor { color in
            XCTAssert(color == Color.white)
        }
    }
    
    func testKernelGivesRightValue() {
        
        let context = allWhite_3x3_Bitmap_Fixture()
        let kernel = BitmapKernel.threeByThree
        
        let kernelValue = kernel.getKernalValue(from: context.bitmap, at: Coordinate(x: 1, y: 1))
        
        XCTAssert(kernelValue == 1.0)
        
    }
}


// Fixtures
extension BitmapKernelTests {
    
    func allWhite_10x10_Bitmap_Fixture() -> BitmapContext {
        
        let fakeBitmap = FakeBitmap(width: 10, height: 10)
        let bitmapContext = BitmapContext(bitmapTarget: fakeBitmap)
        
        bitmapContext.forEachCoordinate { coord in
            bitmapContext.set(color: Color.white, at: coord)
        }
        
        return bitmapContext
    }
    
    func allWhite_3x3_Bitmap_Fixture() -> BitmapContext {
        
        let fakeBitmap = FakeBitmap(width: 3, height: 3)
        let bitmapContext = BitmapContext(bitmapTarget: fakeBitmap)
        
        bitmapContext.forEachCoordinate { coord in
            bitmapContext.set(color: Color.white, at: coord)
        }
        
        return bitmapContext
    }
}
