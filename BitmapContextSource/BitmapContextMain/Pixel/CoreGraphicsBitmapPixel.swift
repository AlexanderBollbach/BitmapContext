//
//  Pixel.swift
//  BitmapContextTests
//
//  Created by Alexander Bollbach on 5/1/18.
//  Copyright © 2018 Bollbach, Alexander. All rights reserved.
//

import Foundation

class CoreGraphicsBitmapPixel: BitmapPixel {
    
    var rByte: UnsafeMutablePointer<UInt8>!
    var gByte: UnsafeMutablePointer<UInt8>!
    var bByte: UnsafeMutablePointer<UInt8>!
    var aByte: UnsafeMutablePointer<UInt8>!
    
    init(memory: UnsafeMutablePointer<UInt32>) {
        
        memory.withMemoryRebound(to: UInt8.self, capacity: 4) { bytes in
            self.rByte = bytes.advanced(by: 0)
            self.gByte = bytes.advanced(by: 1)
            self.bByte = bytes.advanced(by: 2)
            self.aByte = bytes.advanced(by: 3)
        }
    }
    
    var color: BitmapColor {
        get {
            return BitmapColor(
                r: Double(rByte.pointee) / 255,
                g: Double(gByte.pointee) / 255,
                b: Double(bByte.pointee) / 255,
                a: Double(aByte.pointee) / 255
            )
        }
        set {
            rByte.pointee = UInt8(newValue.r * 255)
            gByte.pointee = UInt8(newValue.g * 255)
            bByte.pointee = UInt8(newValue.b * 255)
            aByte.pointee = UInt8(newValue.a * 255)
        }
    }
    
    func darken(by percent: Double) {}
    func brighten(by percent: Double) {}
}
