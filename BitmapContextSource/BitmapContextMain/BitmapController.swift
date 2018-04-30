//
//  Bitmap.swift
//  bitmapTest
//
//  Created by Alexander Bollbach on 4/26/18.
//  Copyright © 2018 Bollbach, Alexander. All rights reserved.
//

import CoreGraphics
import Foundation
//
//class BitmapController {
//
//    let bitmap: Bitmap
//
//    var width: Int {
//        return bitmap.width
//    }
//
//    var height: Int {
//        return bitmap.height
//    }
//
//    var pointCount: Int {
//        return width * height
//    }
//
//    init(bitmap: Bitmap) {
//        self.bitmap = bitmap
//    }
//
//    func set(color: Color, at coordinate: Coordinate) {
//        bitmap.set(color: color, coordinate: coordinate)
//    }
//
//    func getColor(at coordinate: Coordinate) -> Color {
//        return bitmap.getColor(at: coordinate)
//    }
//
//    func forEachCoordinate(f: (Coordinate) -> Void) {
//
//        for row in 0..<width {
//            for col in 0..<row {
//                f(Coordinate(x: col, y: row))
//            }
//        }
//    }
//}
//
//
//
//
//extension BitmapController {
//
//    func algo1() {
//
//        guard let kernel = BitmapKernel.threeByThree else { return }
//
//        forEachCoordinate { coord in
//            bitmap.brightenPixel(coordinate: coord, percent: 0.1)
//        }
//    }
//}
//

// debugging
//extension AbstractBitmap {
//
//    func drawKernal(coordinate: Coordinate) {
//
//        for coord in kernalCoordinates(startingAt: coordinate) {
//            setPixel(coordinate: coord, color: Color.red)
//        }
//    }
//
//    func logPixels() {
//
//        for i in 0..<numberOfPixels {
//            bytes.advanced(by: i).withMemoryRebound(to: UInt8.self, capacity: 4) { pixel in
//
//                print("pixel \(i)")
//                print("r: \(pixel.advanced(by: 0).pointee)")
//                print("r: \(pixel.advanced(by: 1).pointee)")
//                print("r: \(pixel.advanced(by: 2).pointee)")
//                print("r: \(pixel.advanced(by: 3).pointee)")
//            }
//        }
//    }
//
//    func logPixel(at index: Int) {
//
//        bytes.advanced(by: index).withMemoryRebound(to: UInt8.self, capacity: 4) { pixel in
//            print("pixel \(index)")
//            print("r: \(pixel.advanced(by: 0).pointee)")
//            print("r: \(pixel.advanced(by: 1).pointee)")
//            print("r: \(pixel.advanced(by: 2).pointee)")
//            print("r: \(pixel.advanced(by: 3).pointee)")
//        }
//    }
//
//    func logPixel(at coordinate: Coordinate) {
//
//        let indexToScan = index(from: coordinate)
//
//        bytes.advanced(by: indexToScan).withMemoryRebound(to: UInt8.self, capacity: 4) { pixel in
//            print("pixel \(indexToScan)")
//            print("r: \(pixel.advanced(by: 0).pointee)")
//            print("r: \(pixel.advanced(by: 1).pointee)")
//            print("r: \(pixel.advanced(by: 2).pointee)")
//            print("r: \(pixel.advanced(by: 3).pointee)")
//        }
//    }
//}

