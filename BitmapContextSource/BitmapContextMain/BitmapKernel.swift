import Foundation

struct BitmapKernel {
    
    private let backingMatrix: SquareMatrix<Double>
    
    func getKernalValue(from bitmap: Bitmap, at coordinate: Coordinate) -> Double {
        
        let mHalf = backingMatrix.size / 2
        var total = 0.0
        
        for row in backingMatrix.entries.enumerated() {
            for col in row.element.enumerated() {
                
                let xOffset = col.offset - mHalf
                let yOffset = row.offset - mHalf
                
                let currentWeight = backingMatrix.entries[row.offset][col.offset]
                
                if let newCoord = newCoordinate(from: coordinate,
                                                transformedBy: Coordinate(x: xOffset, y: yOffset),
                                                in: bitmap) {

                    total += bitmap.getColor(at: newCoord).magnitude * currentWeight
                    
                } else {
                    total += 1.0 // if off edge treat it as full pixel??
                }
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
    
    private func newCoordinate(from coordinate: Coordinate, transformedBy kernelPoint: Coordinate, in bitmap: Bitmap) -> Coordinate? {
        
        let newCoordinate = Coordinate(x: coordinate.x + kernelPoint.x, y: coordinate.y + kernelPoint.y)
        
        if newCoordinate.x >= 0 && newCoordinate.x < bitmap.width && newCoordinate.y >= 0 && newCoordinate.y < bitmap.height {
            return newCoordinate
        }
        
        return nil
    }
}
