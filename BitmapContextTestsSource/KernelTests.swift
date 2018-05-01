//
//  BitmapKernelTests.swift
//  BitmapContextTests
//
//  Created by Alexander Bollbach on 4/27/18.
//  Copyright © 2018 Bollbach, Alexander. All rights reserved.
//

import XCTest
@testable import BitmapContext

class KernelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    

    
    func testKernelGivesRightValue() {
        
        let bitmap = allWhite_3x3_Bitmap_Fixture()
        guard let kernel = BitmapKernel.threeByThree else { XCTFail("failed to make kernel") ; return }
        
        let kernelValue = kernel.getKernalValue(from: bitmap, at: Coordinate(x: 1, y: 1))
        
        XCTAssert(kernelValue == 1.0)
    }
    
    
    func testKernelExtendsBeyondEdgesUsesFullValue() {
        
        let bitmap = allWhite_3x3_Bitmap_Fixture()
        guard let kernel = BitmapKernel.threeByThree else { XCTFail("failed to make kernel") ; return }
        
        let kernelValue = kernel.getKernalValue(from: bitmap, at: Coordinate(x: 0, y: 0))
        
        XCTAssert(kernelValue == 1.0)
    }
    
    // Note: this is a scary test. a) you need to know a fair amount about the pixel units and amounts.  and b) it doues a lot of casting between Int and Double.  so i use numbers that I know will result in all integer intermediate calculations but still exercise (hopefully) the critical logic of this kernel function
    func testWeightOnKernel1() {
        
        let bitmap = allWhite_3x3_Bitmap_Fixture()
        
        guard let kernel_Unweighted = BitmapKernel(
            from: [
                [ 1.0, 1.0, 1.0],
                [ 1.0, 1.0, 1.0],
                [ 1.0, 1.0, 1.0]
            ]
            ) else { XCTFail("failed to make kernel") ; return }
        
        guard let kernel_Middle_Zero_Weighted = BitmapKernel(
            from: [
                [ 1.0, 1.0, 1.0],
                [ 1.0, 0, 1.0],
                [ 1.0, 1.0, 1.0]
            ]
            ) else { XCTFail("failed to make kernel") ; return }
        
        
        let unWeightedResult = kernel_Unweighted.getKernalValue(from: bitmap, at: Coordinate(x: 1, y: 1))
        let weightedResult = kernel_Middle_Zero_Weighted.getKernalValue(from: bitmap, at: Coordinate(x: 1, y: 1))
        
        let delta = unWeightedResult - weightedResult
        
        // delta should be 1 - 8/9 because the middle weight removes one full white pixel from the kernal multiplication
        let expectedDelta = 1 - 8.0 / 9
        
        XCTAssert(delta == expectedDelta)
    }
}


// Fixtures
extension XCTestCase {
    
    
    func allWhite_10x10_Bitmap_Fixture() -> Bitmap {
        
        let bitmap = FakeBitmap(width: 10, height: 10)
        bitmap.allWhite()
        return bitmap
    }
    
    func allWhite_3x3_Bitmap_Fixture() -> Bitmap {
        
        let bitmap = FakeBitmap(width: 3, height: 3)
        bitmap.allWhite()
        return bitmap
    }
}
