import XCTest
@testable import BitmapContext

class SquareMatrixTests: XCTestCase {
   
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
