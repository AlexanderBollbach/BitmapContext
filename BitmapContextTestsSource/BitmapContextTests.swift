import XCTest
@testable import BitmapContext

class BitmapContextTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testIndexToCoordinate() {
        
        let sut = BitmapContext(bitmapTarget: FakeBitmap(width: 3, height: 3))
        
        var actualCoordinate = sut.coordinate(from: 3)
        var expectedCoordinate = Coordinate(x: 0, y: 1)
        XCTAssert(actualCoordinate == expectedCoordinate)
        
        actualCoordinate = sut.coordinate(from: 0)
        expectedCoordinate = Coordinate(x: 0, y: 0)
        XCTAssert(actualCoordinate == expectedCoordinate)
        
        actualCoordinate = sut.coordinate(from: 8)
        expectedCoordinate = Coordinate(x: 2, y: 2)
        XCTAssert(actualCoordinate == expectedCoordinate)
    }
    
    
    func testCoordinateToIndex() {
        
        let sut = BitmapContext(bitmapTarget: FakeBitmap(width: 3, height: 3))
        
        var expectedIndex = 0
        var actualIndex = sut.index(from: Coordinate(x: 0, y: 0))
        XCTAssert(actualIndex == expectedIndex)
        
        
        actualIndex = sut.index(from: Coordinate(x: 2, y: 2))
        expectedIndex = 8
        XCTAssert(actualIndex == expectedIndex)
        
    }
    
    func testSetsColorsRight() {
        
        let fakeBitmap = FakeBitmap(width: 10, height: 10)
        let bitmapContext = BitmapContext(bitmapTarget: fakeBitmap)
        
        bitmapContext.forEachCoordinate { coord in
            
            bitmapContext.set(color: Color.red, at: coord)
        }
        
        bitmapContext.forEachColor { color in
        
            XCTAssert(color == Color.red)
        }
    }
}
