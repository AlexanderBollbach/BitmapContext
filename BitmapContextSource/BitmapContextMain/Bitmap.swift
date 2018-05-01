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
        
        log()
        
        forEachCoordinate { coord in

            let value = k.getKernalValue(from: self, at: coord)

            print(value)
        }
        
    }
}

class FakeBitmap: Bitmap {
     
    let width: Int
    let height: Int
    
    init(width: Int, height: Int) {
        self.width = width
        self.height = height
    }
    
    func log() {
        
        var byX = fakeStorage.sorted { (d1, d2) in
            
            if d1.key.y != d2.key.y {
                return d1.key.y > d2.key.y
            } else {
                return d1.key.x > d2.key.x
            }
        }
       
        for kv in byX {
            
            print("\(kv.key.x) \(kv.key.y)")
            print("\(kv.value.red) \(kv.value.green) \(kv.value.blue) ")
        }
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
    
    func logPixel(bytes: UnsafePointer<UInt32>) {
        
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
