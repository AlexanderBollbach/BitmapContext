import Foundation

class FakeBitmap: Bitmap {
    
    let width: Int
    let height: Int
    
    init(width: Int, height: Int) {
        self.width = width
        self.height = height
    }

    var fakeStorage: [BitmapCoordinate: BitmapPixel] = [:]
    
    func set(color: BitmapColor, coordinate: BitmapCoordinate) {
        
        if let pixel = fakeStorage[coordinate] {
            pixel.color = color
        } else {
            let newPixel = FakePixel()
            newPixel.color = color
            fakeStorage[coordinate] = newPixel
        }
    }
    
    func getColor(at coordinate: BitmapCoordinate) -> BitmapColor {
        return fakeStorage[coordinate]!.color
    }
    
    func darken(coordinate: BitmapCoordinate, percent: Double) {
        fakeStorage[coordinate]?.darken(by: percent)
    }
    
    func brighten(coordinate: BitmapCoordinate, percent: Double) {
        fakeStorage[coordinate]?.brighten(by: percent)
    }
}

// Logging
extension FakeBitmap {
    
    func log() {
        let byX = fakeStorage.sorted { (d1, d2) in
            
            if d1.key.y != d2.key.y {
                return d1.key.y > d2.key.y
            } else {
                return d1.key.x > d2.key.x
            }
        }
        
        for kv in byX {
            print("\(kv.key.x) \(kv.key.y)")
            print("\(kv.value)")
        }
    }
}
