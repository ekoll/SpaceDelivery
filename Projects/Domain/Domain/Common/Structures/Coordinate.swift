//
//  Coordinate.swift
//  Domain
//
//  Created by Ekrem Duvarbasi on 16.10.2021.
//
import Foundation

public struct Coordinate: Equatable {
    public static var zero: Coordinate { .init(x: 0, y: 0) }
    
    public var x: Double
    public var y: Double
    
    public init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
    
    public func distance(from target: Coordinate) -> Double {
        let x = pow(Double(target.x - x), 2)
        let y = pow(Double(target.y - y), 2)
        
        return sqrt(x + y)
    }
}
