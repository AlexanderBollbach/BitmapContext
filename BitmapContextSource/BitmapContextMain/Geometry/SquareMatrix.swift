//
//  SquareMatrix.swift
//  BitmapContext
//
//  Created by Alexander Bollbach on 4/29/18.
//  Copyright © 2018 Bollbach, Alexander. All rights reserved.
//

import Foundation


struct SquareMatrix<T> {
    
    let rowMajor = true // each element is a row, each sub element a column in a row
    
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
        
        let rowCount = entries.count
     
        // all columns count == rowCount
        for col in entries {
            if col.count != rowCount {
                return false
            }
        }
        
        return true
    }
}
