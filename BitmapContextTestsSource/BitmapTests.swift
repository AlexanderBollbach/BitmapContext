import XCTest
@testable import BitmapContext

class BitmapTests: XCTestCase {

    func testSetsColorsRight() {
        
        let bitmap = FakeBitmap(width: 10, height: 10)
        
        bitmap.forEachCoordinate { coord in
            bitmap.set(color: BitmapColor.red, coordinate: coord)
        }
        
        bitmap.forEachCoordinate(f: { coord in
            let color = bitmap.getColor(at: coord)
            XCTAssert(color == BitmapColor.red)
        })
    }
    
    func testAllColorsWhite() {
        
        let bitmap = allWhite_10x10_Bitmap_Fixture()
        
        bitmap.forEachCoordinate(f: { coord in
            
            let color = bitmap.getColor(at: coord)
            XCTAssert(color == BitmapColor.white)
        })
        
    }
}
