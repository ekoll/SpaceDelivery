//
//  ShipBuildViewModel.swift
//  Presentation
//
//  Created by Ekrem Duvarbasi on 17.10.2021.
//

import Domain

public class ShipBuildViewModel {
    private var blueprint: SpaceshipBlueprint
    private let usecase: BuildSpaceshipUseCase
    private let router: ShipBuildRouter
    public weak var view: Renderer?
    
    public init(blueprint: SpaceshipBlueprint, usecase: BuildSpaceshipUseCase, router: ShipBuildRouter) {
        self.blueprint = blueprint
        self.usecase = usecase
        self.router = router
    }
}

// MARK: - funcs
extension ShipBuildViewModel {
    public func update(name: String) {
        blueprint.name = name
    }
    
    public func increaseDurability() {
        blueprint.increaseDurability()
        view?.updateUI()
    }
    
    public func increaseSpeed() {
        blueprint.increaseSpeed()
        view?.updateUI()
    }
    
    public func increaseCapacity() {
        blueprint.increaseCapacity()
        view?.updateUI()
    }
    
    public func decreaseDurability() {
        blueprint.decreaseDurability()
        view?.updateUI()
    }
    
    public func decreaseSpeed() {
        blueprint.decreaseSpeed()
        view?.updateUI()
    }
    
    public func decreaseCapacity() {
        blueprint.decreaseCapacity()
        view?.updateUI()
    }
    
    public func startGame() {
        do {
            let ship = try usecase.build(from: blueprint)
            router.presentGame(ship: ship)
        }
        catch let error as AppError {
            view?.present(error: error.message)
        }
        catch {
            view?.present(error: "Something happened")
        }
    }
}

// MARK: - viewmodel
extension ShipBuildViewModel {
    public var availablePointText: String {
        "\(availabelPoint)/\(blueprint.maxAbilityPoints)"
    }
    
    public var name: String { blueprint.name }
    
    public var capacity: Int { blueprint.capacity }
    public var capacityRatio: Double { Double(blueprint.capacity) / Double(blueprint.maxAbilityPoints) }
    
    public var speed: Int { blueprint.speed }
    public var speedRatio: Double { Double(blueprint.speed) / Double(blueprint.maxAbilityPoints) }
    
    public var durability: Int { blueprint.durability }
    public var durabilityRatio: Double { Double(blueprint.durability) / Double(blueprint.maxAbilityPoints) }
}

// MARK: - private computations
private extension ShipBuildViewModel {
    var availabelPoint: Int {
        blueprint.maxAbilityPoints - (blueprint.capacity + blueprint.speed + blueprint.durability)
    }
}
