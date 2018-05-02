//
//  FakeBitmap.swift
//  BitmapContextTests
//
//  Created by Alexander Bollbach on 5/1/18.
//  Copyright © 2018 Bollbach, Alexander. All rights reserved.
//

import Foundation

class FakeBitmap: Bitmap {
    
    let width: Int
    let height: Int
    
    init(width: Int, height: Int) {
        self.width = width
        self.height = height
    }
    
    func log() {
        
        let byX = fakeStorage.sorted { (d1, d2) in
            
            if d1.key.y != d2.key.y {
                return d1.key.y > d2.key.y
            } else {
                return d1.key.x > d2.key.x
            }
        }
        
        for kv in byX {
            
            print("\(kv.key.x) \(kv.key.y)")
            print("\(kv.value.r) \(kv.value.g) \(kv.value.b) ")
        }
    }
    
    var fakeStorage: [Coordinate: Color] = [:]
    
    func set(color: Color, coordinate: Coordinate) {
        fakeStorage[coordinate] = color
    }
    
    func getColor(at coordinate: Coordinate) -> Color {
        return fakeStorage[coordinate]!
    }
    
    func darken(coordinate: Coordinate, percent: Double) {}
    func brighten(coordinate: Coordinate, percent: Double) {}
}
