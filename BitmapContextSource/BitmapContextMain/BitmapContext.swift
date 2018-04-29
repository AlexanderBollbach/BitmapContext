//
//  Bitmap.swift
//  bitmapTest
//
//  Created by Alexander Bollbach on 4/26/18.
//  Copyright © 2018 Bollbach, Alexander. All rights reserved.
//

import CoreGraphics
import Foundation

class BitmapContext {
    
    let bitmap: Bitmap
    
    var width: Int {
        return bitmap.width
    }
    
    var height: Int {
        return bitmap.height
    }
    
    var numberOfPixels: Int {
        return width * height
    }

    init(bitmapTarget: Bitmap) {
        self.bitmap = bitmapTarget
    }
    
    func coordinate(from index: Int) -> Coordinate {
        
        let y = Int(index / width)
        let x = index - (y * width)
        
        return Coordinate(x: x, y: y)
    }
    
    func index(from coordinate: Coordinate) -> Int {
        return (width * coordinate.y) + coordinate.x
    }
    
    func set(color: Color, at coordinate: Coordinate) {
        bitmap.set(color: color, coordinate: coordinate)
    }
    
    func getColor(at coordinate: Coordinate) -> Color {
        return bitmap.getColor(at: coordinate)
    }
    
    func forEachCoordinate(f: (Coordinate) -> Void) {
        
        for i in 0..<numberOfPixels {
            
            let coord = coordinate(from: i)
            f(coord)
        }
    }
    
    func forEachColor(f: (Color) -> Void) {
        
        for i in 0..<numberOfPixels {
            
            let coord = coordinate(from: i)
            let color = bitmap.getColor(at: coord)
            f(color)
        }
    }
}




extension BitmapContext {
    
    func algo1() {
        
        guard let kernel = BitmapKernel.threeByThree else { return }
        
        for i in 0..<numberOfPixels {
            
            bitmap.darkenPixel(coordinate: coordinate(from: i), percent: 0.1)
        }
        
        for i in 0..<numberOfPixels {
            
            
            let value = kernel.getKernalValue(from: bitmap, at: coordinate(from: i))
            
            //            bitmapTarget.brightenPixel(coordinate: coordinate(from: i), percent: kernelVal)
        }
    }
}


// debugging
//extension AbstractBitmap {
//
//    func drawKernal(coordinate: Coordinate) {
//
//        for coord in kernalCoordinates(startingAt: coordinate) {
//            setPixel(coordinate: coord, color: Color.red)
//        }
//    }
//
//    func logPixels() {
//
//        for i in 0..<numberOfPixels {
//            bytes.advanced(by: i).withMemoryRebound(to: UInt8.self, capacity: 4) { pixel in
//
//                print("pixel \(i)")
//                print("r: \(pixel.advanced(by: 0).pointee)")
//                print("r: \(pixel.advanced(by: 1).pointee)")
//                print("r: \(pixel.advanced(by: 2).pointee)")
//                print("r: \(pixel.advanced(by: 3).pointee)")
//            }
//        }
//    }
//
//    func logPixel(at index: Int) {
//
//        bytes.advanced(by: index).withMemoryRebound(to: UInt8.self, capacity: 4) { pixel in
//            print("pixel \(index)")
//            print("r: \(pixel.advanced(by: 0).pointee)")
//            print("r: \(pixel.advanced(by: 1).pointee)")
//            print("r: \(pixel.advanced(by: 2).pointee)")
//            print("r: \(pixel.advanced(by: 3).pointee)")
//        }
//    }
//
//    func logPixel(at coordinate: Coordinate) {
//
//        let indexToScan = index(from: coordinate)
//
//        bytes.advanced(by: indexToScan).withMemoryRebound(to: UInt8.self, capacity: 4) { pixel in
//            print("pixel \(indexToScan)")
//            print("r: \(pixel.advanced(by: 0).pointee)")
//            print("r: \(pixel.advanced(by: 1).pointee)")
//            print("r: \(pixel.advanced(by: 2).pointee)")
//            print("r: \(pixel.advanced(by: 3).pointee)")
//        }
//    }
//}

