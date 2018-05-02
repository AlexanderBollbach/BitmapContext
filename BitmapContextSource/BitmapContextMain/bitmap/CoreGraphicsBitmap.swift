//
//  CoreGraphicsBitmap.swift
//  BitmapContextTests
//
//  Created by Alexander Bollbach on 5/1/18.
//  Copyright © 2018 Bollbach, Alexander. All rights reserved.
//

import Foundation
import CoreGraphics

class CoreGraphicsBitmap: Bitmap {
    
    private let context: CGContext
    private let bytes: UnsafeMutablePointer<UInt32>
    
    var width: Int { return context.width }
    var height: Int { return context.height }
    
    init(context: CGContext) {
        self.context = context
        self.bytes = context.data!.assumingMemoryBound(to: UInt32.self)
    }
    
    func set(color: Color, coordinate: Coordinate) {
        pixel(at: coordinate).color = color
    }
    
    func getColor(at coordinate: Coordinate) -> Color {
        return pixel(at: coordinate).color
    }
    
    func darken(coordinate: Coordinate, percent: Double) {
        pixel(at: coordinate).darken(by: percent)
    }
    
    func brighten(coordinate: Coordinate, percent: Double) {
        pixel(at: coordinate).brighten(by: percent)
    }
}

// logging
extension CoreGraphicsBitmap {
    
    func logPixel(bytes: UnsafeMutablePointer<UInt32>) {
        
        bytes.withMemoryRebound(to: UInt8.self, capacity: 4) { byte in
            let r = byte.advanced(by: 0).pointee
            let g = byte.advanced(by: 1).pointee
            let b = byte.advanced(by: 2).pointee
            let a = byte.advanced(by: 3).pointee
            
            print("r: \(r)")
            print("g: \(g)")
            print("b: \(b)")
            print("a: \(a)")
        }
    }
    
    func log() {
        
        forEachCoordinate { coord in
            let advance = coord.x + (coord.y * width)
            logPixel(bytes: self.bytes.advanced(by: advance))
        }
    }
}

// private
extension CoreGraphicsBitmap {

    private func getByteOffset(from coordinate: Coordinate) -> Int {
        return coordinate.x + (coordinate.y * width)
    }
    
    private func pixel(at coordinate: Coordinate) -> BitmapPixel {
        return CoreGraphicsBitmapPixel(memory: bytes.advanced(by: getByteOffset(from: coordinate)))
    }
}
