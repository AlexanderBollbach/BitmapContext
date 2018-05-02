//
//  BitmapColor.swift
//  BitmapContextTests
//
//  Created by Alexander Bollbach on 5/1/18.
//  Copyright © 2018 Bollbach, Alexander. All rights reserved.
//

import Foundation

struct BitmapColor: Equatable {
    
    var r: Double
    var g: Double
    var b: Double
    var a: Double
    
    var magnitude: Double {
        return (r + g + b + a) / 4
    }
    
    var rgbMagnitude: Double {
        return (r + g + b) / 3
    }
    
    static var red: BitmapColor {
        return BitmapColor(r: 1, g: 0, b: 0, a: 1)
    }
    static var white: BitmapColor {
        return BitmapColor(r: 1, g: 1, b: 1, a: 1)
    }
    static var black: BitmapColor {
        return BitmapColor(r: 0, g: 0, b: 0, a: 1)
    }
}
