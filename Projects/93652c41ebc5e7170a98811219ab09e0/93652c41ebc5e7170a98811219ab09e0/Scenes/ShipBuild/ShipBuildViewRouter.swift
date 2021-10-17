//
//  ShipBuildViewRouter.swift
//  93652c41ebc5e7170a98811219ab09e0
//
//  Created by Ekrem Duvarbasi on 17.10.2021.
//

import Domain
import Presentation

class ShipBuildViewRouter: BaseRouter, ShipBuildRouter {
    func presentGame(ship: Spaceship) {
        let container = generateContainer(ship: ship)
        
        let viewModel = SpaceViewModel(
            spaceship: ship,
            shipLocation: .init(name: ship.stationName, coorditnate: ship.coordinate),
            stations: container.resolve(),
            spaceUsecase: container.resolve(),
            favoriteUsecase: container.resolve()
        )
        
        print("Station count:", viewModel.stations.data.count)
    }
    
    func generateContainer(ship: Spaceship) -> DependencyContainer {
        let container = DependencyContainer(parent: container)
        
        container.append(type: SpaceUseCase.self) { cont in
            let home: HomeStation = cont.resolve()
            return SpaceInteractor(damageByTime: 10, homeName: home.name, home: home.coordinate)
        }
        container.append(type: FavoriteStationUseCase.self, generator: { cont in
            StationLoader(repository: cont.resolve(), favouriteRepository: cont.resolve())
            
        })
        
        return container
    }
}
