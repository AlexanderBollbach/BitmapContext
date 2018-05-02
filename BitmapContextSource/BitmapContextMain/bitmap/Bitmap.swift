//
//  BitmapTarget.swift
//  bitmapTest
//
//  Created by Alexander Bollbach on 4/26/18.
//  Copyright © 2018 Bollbach, Alexander. All rights reserved.
//

import CoreGraphics
import Foundation


protocol Bitmap {
    
    var width: Int { get }
    var height: Int { get }
    
    func set(color: Color, coordinate: Coordinate)
    func getColor(at coordinate: Coordinate) -> Color
    
    func darken(coordinate: Coordinate, percent: Double)
    func brighten(coordinate: Coordinate, percent: Double)
    
    func forEachCoordinate(f: (Coordinate) -> Void)
    
    func allWhite()
    
    func log()
}

extension Bitmap {
    
    func forEachCoordinate(f: (Coordinate) -> Void) {
        
        for row in 0..<height {
            for col in 0..<width {
                f(Coordinate(x: col, y: row))
            }
        }
    }
    
    func allWhite() {
        forEachCoordinate { coord in
            self.set(color: Color.white, coordinate: coord)
        }
    }
}

// algorithms
extension Bitmap {
    
    func algo1() {
        
        guard let k = BitmapKernel.threeByThree else { fatalError() }
        
       
        forEachCoordinate { coord in

            let value = k.getKernalValue(from: self, at: coord)
            
            if value > 0.5 {
                self.darken(coordinate: coord, percent: 0.1)
            }

            print(value)
        }
        
    }
}



