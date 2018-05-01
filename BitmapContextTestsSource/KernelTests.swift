import XCTest
@testable import BitmapContext

class KernelTests: XCTestCase {
    
    func testKernelGivesRightValue() {
        
        let bitmap = allWhite_3x3_Bitmap_Fixture()
        guard let kernel = BitmapKernel.threeByThree else { XCTFail("failed to make kernel") ; return }
        
        let kernelValue = kernel.getKernalValue(from: bitmap, at: Coordinate(x: 1, y: 1))
        
        XCTAssert(kernelValue == 1.0)
    }
    
    
    func testKernelExtendsBeyondEdgesUsesFullValue() {
        
        let bitmap = allWhite_3x3_Bitmap_Fixture()
        guard let kernel = BitmapKernel.init(
            from: [
                [ 1.0, 1.0, 1.0],
                [ 1.0, 1.0, 1.0],
                [ 1.0, 1.0, 1.0]
            ]) else { XCTFail("failed to make kernel") ; return }
        
        var kernelValue = kernel.getKernalValue(from: bitmap, at: Coordinate(x: 0, y: 0))
        
        XCTAssert(kernelValue == 1.0)
        
        let topRightCoord = Coordinate(x: bitmap.width - 1, y: bitmap.height - 1)
        kernelValue = kernel.getKernalValue(from: bitmap, at: topRightCoord)
        
        XCTAssert(kernelValue == 1.0)
    }
    
    // given: the kernel returns 1.0 for coordinates outside the bounds of a bitmap
    // in this case the kernel is all full weights and the bitmap is all full color
    // therefore, the value at every index should be 1.0
    func testKernelGivesAll1s() {
        
        let bitmap = allWhite_3x3_Bitmap_Fixture()
        guard let kernel = BitmapKernel.init(
            from: [
                [ 1.0, 1.0, 1.0],
                [ 1.0, 1.0, 1.0],
                [ 1.0, 1.0, 1.0]
            ]) else { XCTFail("failed to make kernel") ; return }

        bitmap.forEachCoordinate { coord in
            
            let value = kernel.getKernalValue(from: bitmap, at: coord)
            XCTAssert(value == 1.0)
        }
    }
    
    // Note: this is a scary test. a) you need to know a fair amount about the pixel units and amounts.  and b) it doues a lot of casting between Int and Double.  so i use numbers that I know will result in all integer intermediate calculations but still exercise (hopefully) the critical logic of this kernel function
    func testSingle0WeightDelta() {
        
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
