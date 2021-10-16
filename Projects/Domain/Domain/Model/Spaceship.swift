//
//  Spaceship.swift
//  Domain
//
//  Created by Ekrem Duvarbasi on 16.10.2021.
//

import Foundation

public struct Spaceship {
    public var name: String = ""
    public var capacity: Int = 0
    public var universalSpaceTime: Int = 0
    public var durabilityTime: TimeInterval = 0
    public var maxHealth: Int = 100
    
    public var coordinate: Coordinate = .zero
}
