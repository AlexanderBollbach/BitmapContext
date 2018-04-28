//
//  BitmapKernel.swift
//  bitmapTest
//
//  Created by Alexander Bollbach on 4/27/18.
//  Copyright © 2018 Bollbach, Alexander. All rights reserved.
//

import Foundation

struct BitmapKernel {
    
    private struct Entry {
        let x: Int
        let y: Int
        let weight: Double
    }
    
    private let entries: [[Entry]]
    
    func getKernalValue(from bitmap: Bitmap, at coordinate: Coordinate) -> Double {
        
        let total = entries.reduce(0.0) { (result, matrixRow) in
            
            let rowTotal = matrixRow.reduce(0.0) { result, entry in
                
                if let coord = newCoordinate(from: coordinate, transformedBy: entry, in: bitmap) {
                    return result + (Double(bitmap.getColor(at: coord).sumRGB) * entry.weight)
                }
                return result
            }
            
            return result + rowTotal
        }
        
        return total
    }
    
    func normalizeValue(_ value: Int) -> Double {
        
        let maxKernelVal = Double(Color.maxRGBValue * entries.count)
        return Double(value) / maxKernelVal
    }
    
    private func newCoordinate(from coordinate: Coordinate, transformedBy entry: Entry, in bitmap: Bitmap) -> Coordinate? {
        
        let newCoordinate = Coordinate(x: coordinate.x + entry.x, y: coordinate.y + entry.y)
        
        if newCoordinate.x >= 0 && newCoordinate.x < bitmap.width && newCoordinate.y >= 0 && newCoordinate.y < bitmap.height {
            return newCoordinate
        }
        
        return nil
    }
}

extension BitmapKernel {
    
    
    init(from matrix: [[Double]]) {
        
        var entries = [[Entry]]()
        
        for iy in 0..<matrix.count {
            
            var rowEntries = [Entry]()
            
            let yEntry = iy - (matrix.count / 2)
            
            let row = matrix[iy]
            
            for ix in 0..<row.count {
                
                let xEntry = ix - (row.count / 2)
                rowEntries.append(Entry(x: xEntry, y: yEntry, weight: row[ix]))
            }
            
            entries.append(rowEntries)
        }
        
        self.entries = entries
    }
    
    
    static var threeByThree: BitmapKernel {
        
        return BitmapKernel(
            from: [
                [ 1.0, 1.0, 1.0],
                [ 1.0, 1.0, 1.0],
                [ 1.0, 1.0, 1.0]
            ]
        )
    }
}
