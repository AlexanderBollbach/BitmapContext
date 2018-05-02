import Foundation

struct BitmapKernel {
    
    private let backingMatrix: SquareMatrix<Double>
    
    func getKernalValue(from bitmap: Bitmap, at coordinate: BitmapCoordinate) -> Double {
        
        let mHalf = backingMatrix.size / 2
        var total = 0.0
        
        for row in backingMatrix.entries.enumerated() {
            for col in row.element.enumerated() {
                
                let xOffset = col.offset - mHalf
                let yOffset = row.offset - mHalf
                
                let currentWeight = backingMatrix.entries[row.offset][col.offset]
                
                let newCoord = newCoordinate(from: coordinate,
                                             transformedBy: BitmapCoordinate(x: xOffset, y: yOffset),
                                             in: bitmap)
                
                total += bitmap.getColor(at: newCoord).rgbMagnitude * currentWeight
            }
        }
        
        return total / Double(backingMatrix.numEntries)
    }
}

// ---- initializers
extension BitmapKernel {
    
    init?(from entries: [[Double]]) {
        if let matrix = SquareMatrix<Double>.init(with: entries) {
            self.backingMatrix = matrix
            return
        }
        return nil
    }
}

// ---- factories
extension BitmapKernel {
    static var threeByThree: BitmapKernel? {
        return BitmapKernel(
            from: [
                [ 1.0, 1.0, 1.0],
                [ 1.0, 1.0, 1.0],
                [ 1.0, 1.0, 1.0]
            ]
        )
    }
}
// ---- Utils
extension BitmapKernel {
    
    private func newCoordinate(from coordinate: BitmapCoordinate, transformedBy kernelPoint: BitmapCoordinate, in bitmap: Bitmap) -> BitmapCoordinate {
        
        var newCoordinate = BitmapCoordinate(x: coordinate.x + kernelPoint.x, y: coordinate.y + kernelPoint.y)
        
        if newCoordinate.x < 0 {
            newCoordinate.x = 0
        }
        
        if newCoordinate.x >= bitmap.width {
            newCoordinate.x = bitmap.width - 1
        }
        
        if newCoordinate.y < 0 {
            newCoordinate.y = 0
        }
        
        if newCoordinate.y >= bitmap.height {
            newCoordinate.y = bitmap.height - 1
        }
        
        return newCoordinate
    }
}
