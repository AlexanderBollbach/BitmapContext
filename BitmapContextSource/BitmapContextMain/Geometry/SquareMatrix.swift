//
//  SquareMatrix.swift
//  BitmapContext
//
//  Created by Alexander Bollbach on 4/29/18.
//  Copyright © 2018 Bollbach, Alexander. All rights reserved.
//

import Foundation

struct SquareMatrix<T> {
    
    var entries: [[T]]
    
    var size: Int
    
    var numEntries: Int {
        return size * size
    }
    
    init?(with entries: [[T]]) {
        
        if !SquareMatrix.isSquare(entries: entries) {
            return nil
        }
        
        self.entries = entries
        self.size = entries.count
    }
    
    static func isSquare(entries: [[T]]) -> Bool {
        return true
    }
}
