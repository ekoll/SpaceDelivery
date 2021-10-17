//
//  LoadingViewRouter.swift
//  93652c41ebc5e7170a98811219ab09e0
//
//  Created by Ekrem Duvarbasi on 17.10.2021.
//

import Domain
import Presentation

class LoadingViewRouter: BaseRouter, AppLoadRouter {
    func presentSpaceshipBuild(stations: [SpaceStation]) {
        let home = getHome(from: stations)
        
        let container = generateContainer(home: home)
        container.append(type: HomeStation.self, generator: { _ in home })
        container.append(type: [SpaceStation].self, generator: { _ in stations })
        
        let viewModel: ShipBuildViewModel = container.resolve()
        print("Shipname:", viewModel.name)
    }
    
    private func getHome(from stations: [SpaceStation]) -> HomeStation {
        if let station = stations.first {
            return .init(name: station.name, coordinate: station.coordinate)
        } else {
            return .init(name: "Void", coordinate: .zero)
        }
    }
    
    private func generateContainer(home: HomeStation) -> DependencyContainer {
        let container = DependencyContainer(parent: self.container)
        
        container.append(type: SpaceshipBlueprint.self, generator: { _ in SpaceshipBlueprint() })
        
        container.append(type: ShipBuildRouter.self, generator: { cont in ShipBuildViewRouter(container: cont) })
        
        container.append(type: BuildSpaceshipUseCase.self, generator: { cont in
            let home: HomeStation = cont.resolve()
            return SpaceshipTechnician(rules: .init(homeName: home.name, homeCoordinate: home.coordinate, maxHealth: 100, capacityMultiplier: 1000, universalSpaceTimeMultiplier: 20, durabilityTimeMultiplier: 10))
        })
        
        container.append(type: ShipBuildViewModel.self, generator: { cont in
            .init(blueprint: cont.resolve(), usecase: cont.resolve(), router: cont.resolve())
        })
        
        return container
    }
}
