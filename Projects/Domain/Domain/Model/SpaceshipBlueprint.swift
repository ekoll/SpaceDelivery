//
//  SpaceshipBlueprint.swift
//  Domain
//
//  Created by Ekrem Duvarbasi on 16.10.2021.
//

import Foundation

public class SpaceshipBlueprint {
    public let maxAbilityPoints: Int
    public var name: String
    private(set) public var durability: Int
    private(set) public var speed: Int
    private(set) public var capacity: Int
    
    public init(name: String = "", maxAbilityPoints: Int = 15) {
        self.name = name
        self.maxAbilityPoints = maxAbilityPoints
        
        let pointPerAbility = maxAbilityPoints / 3
        let arbitraryPoints = maxAbilityPoints % pointPerAbility
        
        durability = pointPerAbility
        speed = pointPerAbility
        capacity = pointPerAbility
        
        for i in 0..<arbitraryPoints {
            switch i {
            case 0: durability += 1
            case 1: speed += 1
            default: break
            }
        }
    }
    
    internal init(name: String = "", maxAbilityPoints: Int = 10, durability: Int = 0, speed: Int = 0, capacity: Int = 0) throws {
        guard durability + speed + capacity <= maxAbilityPoints else {
            throw NSError(domain: "SpaceshipBlueprint", code: 0, userInfo: ["Message": "Total ability points cannot be greater than max ability points"])
        }
        
        self.name = name
        self.maxAbilityPoints = maxAbilityPoints
        self.durability = durability
        self.speed = speed
        self.capacity = capacity
    }
    
    func increaseDurability() {
        let currentLimitForAbility = maxAbilityPoints - (speed + capacity)
        durability = min(durability + 1, currentLimitForAbility)
    }
    
    func increaseSpeed() {
        let currentLimitForAbility = maxAbilityPoints - (durability + capacity)
        speed = min(speed + 1, currentLimitForAbility)
    }
    
    func increaseCapacity() {
        let currentLimitForAbility = maxAbilityPoints - (durability + speed)
        capacity = min(capacity + 1, currentLimitForAbility)
    }
    
    func decreaseDurability() {
        durability = max(durability - 1, 0)
    }
    
    func decreaseSpeed() {
        speed = max(speed - 1, 0)
    }
    
    func decreaseCapacity() {
        capacity = max(capacity - 1, 0)
    }
    
    func validate() throws {
        if name.isEmpty {
            throw ValidationError.emptyName
        }
        
        if durability + speed + capacity < maxAbilityPoints {
            throw ValidationError.unusedPoints
        }
    }
}

extension SpaceshipBlueprint {
    enum ValidationError: String, AppError, CustomStringConvertible {
        case unusedPoints = "There are unused stat points to upgrade ship"
        case emptyName = "This ship does not have a name"
        
        public var message: String { rawValue }
        public var description: String { rawValue }
    }
}
