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
    
    typealias ComponentType = UInt8
    
    let red: ComponentType
    let green: ComponentType
    let blue: ComponentType
    let alpha: ComponentType
    
    var sum: Int {
        return Int(Int(red) + Int(green) + Int(blue) + Int(alpha))
    }
    
    static var maxValue: Int {
        return Int(ComponentType.max) * 4
    }
    
    static var red: Color {
        return Color(red: 255, green: 0, blue: 0, alpha: 255)
    }
}


