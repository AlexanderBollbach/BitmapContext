//
//  BitmapCoordinate.swift
//  BitmapContextTests
//
//  Created by Alexander Bollbach on 5/1/18.
//  Copyright © 2018 Bollbach, Alexander. All rights reserved.
//

import Foundation

struct BitmapCoordinate: Equatable {
    var x: Int
    var y: Int
}

extension BitmapCoordinate: Hashable {
    
    var hashValue: Int {
        return x * y
    }
}
