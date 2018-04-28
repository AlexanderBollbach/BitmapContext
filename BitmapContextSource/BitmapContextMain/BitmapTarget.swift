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
    
    func darkenPixel(coordinate: Coordinate, percent: Double)
    func brightenPixel(coordinate: Coordinate, percent: Double)
}

class FakeBitmap: Bitmap {
     
    let width: Int
    let height: Int
    
    init(width: Int, height: Int) {
        self.width = width
        self.height = height
    }
    
    var fakeStorage: [Coordinate: Color] = [:]
    
    func set(color: Color, coordinate: Coordinate) {
        fakeStorage[coordinate] = color
    }
    
    func getColor(at coordinate: Coordinate) -> Color {
        return fakeStorage[coordinate]!
    }
    
    func darkenPixel(coordinate: Coordinate, percent: Double) {}
    func brightenPixel(coordinate: Coordinate, percent: Double) {}
}

class CoreGraphicsBitmap: Bitmap {
    
    let context: CGContext
    let bytes: UnsafeMutablePointer<UInt32>
    
    var width: Int {
        return context.width
    }
    
    var height: Int {
        return context.height
    }
    
    init(context: CGContext) {
        self.context = context
        self.bytes = context.data!.assumingMemoryBound(to: UInt32.self)
    }
    
    func set(color: Color, coordinate: Coordinate) {
        
        let advance = coordinate.x + (coordinate.y * width)
        
        bytes.advanced(by: advance).withMemoryRebound(to: UInt8.self, capacity: 4) { byte in
            byte.advanced(by: 0).assign(repeating: color.red, count: 1)
            byte.advanced(by: 1).assign(repeating: color.green, count: 1)
            byte.advanced(by: 2).assign(repeating: color.blue, count: 1)
            byte.advanced(by: 3).assign(repeating: color.alpha, count: 1)
        }
    }
    
    func getColor(at coordinate: Coordinate) -> Color {
        
        let advance = coordinate.x + (coordinate.y * width)
        
        var r, g, b, a: UInt8!
        
        bytes.advanced(by: advance).withMemoryRebound(to: UInt8.self, capacity: 4) { byte in
            r = byte.advanced(by: 0).pointee
            g = byte.advanced(by: 1).pointee
            b = byte.advanced(by: 2).pointee
            a = byte.advanced(by: 3).pointee
        }
        
        return Color(red: r, green: g, blue: b, alpha: a)
    }
    
    func updateComponent(offset: Int, bytes: UnsafeMutablePointer<UInt8>, change: Int) {
        
        let c = bytes.advanced(by: offset)
        var newVal = Int(c.pointee) + change
        if newVal < 0 { newVal = 0 }
        if newVal > 255 { newVal = 255 }
        c.assign(repeating: UInt8(newVal), count: 1)
    }
    
    func darkenPixel(coordinate: Coordinate, percent: Double) {
        
        let advance = coordinate.x + (coordinate.y * width)
        
        let componentChange = -Int(255 * percent)
        
        bytes.advanced(by: advance).withMemoryRebound(to: UInt8.self, capacity: 4) { byte in
            
            for i in 0...2 {
                updateComponent(offset: i, bytes: byte, change: componentChange)
            }
        }
    }
    
    func brightenPixel(coordinate: Coordinate, percent: Double) {
        
        let advance = coordinate.x + (coordinate.y * width)
        
        let componentChange = Int(255 * percent)
        
        bytes.advanced(by: advance).withMemoryRebound(to: UInt8.self, capacity: 4) { byte in
            
            for i in 0...2 {
                updateComponent(offset: i, bytes: byte, change: componentChange)
            }
        }
    }
}
