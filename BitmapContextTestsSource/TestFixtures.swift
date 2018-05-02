import Foundation
import XCTest
@testable import BitmapContext

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
