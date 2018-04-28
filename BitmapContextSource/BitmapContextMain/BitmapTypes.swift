//
//  BitmapTypes.swift
//  bitmapTest
//
//  Created by Alexander Bollbach on 4/26/18.
//  Copyright © 2018 Bollbach, Alexander. All rights reserved.
//

import Foundation

struct Coordinate: Equatable {
    let x: Int
    let y: Int
}

extension Coordinate: Hashable {

    var hashValue: Int {
        return x * y
    }
}

struct Color: Equatable {
    
    // alpha always 1 for now
    
    typealias ComponentType = UInt8
    
    let red: ComponentType
    let green: ComponentType
    let blue: ComponentType
    let alpha: ComponentType
    
    var sumRGB: Int {
        return Int(Int(red) + Int(green) + Int(blue))
    }
    
    static var maxRGBValue: Int {
        return Int(ComponentType.max) * 3
    }
    
    static var red: Color {
        return Color(red: 255, green: 0, blue: 0, alpha: 255)
    }
    static var white: Color {
        return Color(red: 255, green: 255, blue: 255, alpha: 255)
    }
}


