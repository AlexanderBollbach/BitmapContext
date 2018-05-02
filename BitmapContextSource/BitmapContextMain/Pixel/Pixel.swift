//
//  Pixel.swift
//  BitmapContextTests
//
//  Created by Alexander Bollbach on 5/1/18.
//  Copyright © 2018 Bollbach, Alexander. All rights reserved.
//

import Foundation

protocol BitmapPixel: class {
 
    var color: Color { get set }
    
    func darken(by percent: Double)
    func brighten(by percent: Double)
}
