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
        
        buildMatrix.append(Point(x: -1, y: -1, weight: 0.2)) // top left
        buildMatrix.append(Point(x: 0, y: -1, weight: 0.2)) // top
        buildMatrix.append(Point(x: 1, y: -1, weight: 0.2)) // top right
        
        buildMatrix.append(Point(x: -1, y: 0, weight: 1)) // left
        buildMatrix.append(Point(x: 0, y: 0, weight: 1)) // middle
        buildMatrix.append(Point(x: 1, y: 0, weight: 1)) // right
        
        
        buildMatrix.append(Point(x: -1, y: 1, weight: 0.2)) // bottom left
        buildMatrix.append(Point(x: 0, y: 1, weight: 0.2)) // bottom middle
        buildMatrix.append(Point(x: 1, y: 1, weight: 0.2)) // bottom right
        
        return BitmapKernel(matrix: buildMatrix)
    }
    
    func getKernalValue(from bitmap: Bitmap, at coordinate: Coordinate) -> Double {
        
        var total = 0
        
        for index in matrix {
            
            let kernelX = coordinate.x + index.x
            let kernelY = coordinate.y + index.y
            
            if kernelX < bitmap.width && kernelX >= 0
                && kernelY < bitmap.height && kernelY > 0 {
                
                let mag = bitmap.getColor(at: Coordinate(x: kernelX, y: kernelY)).sum
                total += Int(Double(mag) * index.weight)
            }
        }
        
        let maxKernelVal = Double(Color.maxValue * matrix.count)
        return Double(total) / maxKernelVal
    }
}
