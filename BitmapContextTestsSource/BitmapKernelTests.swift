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
    
    // Note: this is a scary test. a) you need to know a fair amount about the pixel units and amounts.  and b) it doues a lot of casting between Int and Double.  so i use numbers that I know will result in all integer intermediate calculations but still exercise (hopefully) the critical logic of this kernel function
    func testWeightOnKernel1() {
        
        let context = allWhite_3x3_Bitmap_Fixture()
        
        let kernel_Unweighted = BitmapKernel(
            from: [
                [ 1.0, 1.0, 1.0],
                [ 1.0, 1.0, 1.0],
                [ 1.0, 1.0, 1.0]
            ]
        )
        
        let kernel_Middle_Zero_Weighted = BitmapKernel(
            from: [
                [ 1.0, 1.0, 1.0],
                [ 1.0, 0, 1.0],
                [ 1.0, 1.0, 1.0]
            ]
        )
        
        
        let unWeightedResult = kernel_Unweighted.getKernalValue(from: context.bitmap, at: Coordinate(x: 1, y: 1))
        let weightedResult = kernel_Middle_Zero_Weighted.getKernalValue(from: context.bitmap, at: Coordinate(x: 1, y: 1))
        
        let delta = unWeightedResult - weightedResult
        
        XCTAssert(delta == 765)
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
