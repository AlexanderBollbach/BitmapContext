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
    
    func set(color: BitmapColor, coordinate: BitmapCoordinate)
    func getColor(at coordinate: BitmapCoordinate) -> BitmapColor
    
    func darken(coordinate: BitmapCoordinate, percent: Double)
    func brighten(coordinate: BitmapCoordinate, percent: Double)
    
    func forEachCoordinate(f: (BitmapCoordinate) -> Void)
    
    func allWhite()
    
    func log()
}

extension Bitmap {
    
    func forEachCoordinate(f: (BitmapCoordinate) -> Void) {
        
        for row in 0..<height {
            for col in 0..<width {
                f(BitmapCoordinate(x: col, y: row))
            }
        }
    }
    
    func allWhite() {
        forEachCoordinate { coord in
            self.set(color: BitmapColor.white, coordinate: coord)
        }
    }
    func allBlack() {
        forEachCoordinate { coord in
            self.set(color: BitmapColor.black, coordinate: coord)
        }
    }
}

// algorithms
extension Bitmap {
    
    func algo1() {
        
        guard let k = BitmapKernel.threeByThree else { fatalError() }
        
       
        forEachCoordinate { coord in

            let value = k.getKernalValue(from: self, at: coord)
            
            if value > 0.3 {
                self.brighten(coordinate: coord, percent: 0.1)
            }

            print(value)
        }
        
    }
}



