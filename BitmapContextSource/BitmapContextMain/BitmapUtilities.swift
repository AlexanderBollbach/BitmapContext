//
//  BitmapUtilities.swift
//  BitmapContextTests
//
//  Created by Alexander Bollbach on 5/1/18.
//  Copyright © 2018 Bollbach, Alexander. All rights reserved.
//

import Foundation

func pixelComponent(_ component: Double, decrementedBy amount: Double) -> Double {
    
    return component - amount > 0 ? component - amount : 0
}

func pixelComponent(_ component: Double, incrementedBy amount: Double) -> Double {
    
    return component + amount > 0 ? component + amount : 0
}

class BitmapUtilities {
    
    
}
