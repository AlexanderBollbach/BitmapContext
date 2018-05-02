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

    let r: Double
    let g: Double
    let b: Double
    let a: Double
    
    var magnitude: Double {
        return (r + g + b + a) / 4
    }
    
    static var red: Color {
        return Color(r: 1, g: 0, b: 0, a: 1)
    }
    static var white: Color {
        return Color(r: 1, g: 1, b: 1, a: 1)
    }
}


