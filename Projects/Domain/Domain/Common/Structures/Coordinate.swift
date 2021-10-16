//
//  Coordinate.swift
//  Domain
//
//  Created by Ekrem Duvarbasi on 16.10.2021.
//

public struct Coordinate: Equatable {
    public static var zero: Coordinate { .init(x: 0, y: 0) }
    
    public var x: Int
    public var y: Int
}
