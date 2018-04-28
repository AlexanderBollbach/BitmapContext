//
//  BitmapKernel.swift
//  bitmapTest
//
//  Created by Alexander Bollbach on 4/27/18.
//  Copyright © 2018 Bollbach, Alexander. All rights reserved.
//

import Foundation

struct BitmapKernel {
    
    struct Point {
        let x: Int
        let y: Int
        let weight: Double
    }
    
    let matrix: [Point]
    
    static var threeByThree: BitmapKernel {
        
        var buildMatrix = [Point]()
        
        buildMatrix.append(Point(x: -1, y: -1, weight: 1)) // top left
        buildMatrix.append(Point(x: 0, y: -1, weight: 1)) // top
        buildMatrix.append(Point(x: 1, y: -1, weight: 1)) // top right
        
        buildMatrix.append(Point(x: -1, y: 0, weight: 1)) // left
        buildMatrix.append(Point(x: 0, y: 0, weight: 1)) // middle
        buildMatrix.append(Point(x: 1, y: 0, weight: 1)) // right
        
        
        buildMatrix.append(Point(x: -1, y: 1, weight: 1)) // bottom left
        buildMatrix.append(Point(x: 0, y: 1, weight: 1)) // bottom middle
        buildMatrix.append(Point(x: 1, y: 1, weight: 1)) // bottom right
        
        return BitmapKernel(matrix: buildMatrix)
    }
    
    func getKernalValue(from bitmap: Bitmap, at coordinate: Coordinate) -> Double {
       
        let total = matrix.reduce(0) { (result, point) in
            
            if let coord = newCoordinate(from: coordinate, transformedBy: point, in: bitmap) {
                return result + bitmap.getColor(at: coord).sumRGB
            }
            return result
        }
 
        let maxKernelVal = Double(Color.maxRGBValue * matrix.count)
        return Double(total) / maxKernelVal
    }
   
    private func newCoordinate(from coordinate: Coordinate, transformedBy kernelPoint: Point, in bitmap: Bitmap) -> Coordinate? {
        
        let newCoordinate = Coordinate(x: coordinate.x + kernelPoint.x, y: coordinate.y + kernelPoint.y)
        
        if newCoordinate.x >= 0 && newCoordinate.x < bitmap.width && newCoordinate.y >= 0 && newCoordinate.y < bitmap.height {
            return newCoordinate
        }
        
        return nil
    }
}
