//
//  SpaceOperationResult.swift
//  Domain
//
//  Created by Ekrem Duvarbasi on 16.10.2021.
//

public struct SpaceOperationResult<T> {
    public var shipStatus: Spaceship.Status
    public var updated: T
}
