//
//  ShipBuildViewRouter.swift
//  93652c41ebc5e7170a98811219ab09e0
//
//  Created by Ekrem Duvarbasi on 17.10.2021.
//

import Domain
import Presentation
import UIKit

class ShipBuildViewRouter: BaseRouter, ShipBuildRouter {
    func presentGame(ship: Spaceship) {
        guard let controller = UIApplication.shared.getTopViewController() else { return }
        let container = generateContainer(ship: ship)
        
        let viewModel = SpaceViewModel(
            spaceship: ship,
            shipLocation: .init(name: ship.stationName, coorditnate: ship.coordinate),
            stations: container.resolve(),
            spaceUsecase: container.resolve(),
            favoriteUsecase: container.resolve()
        )
        
        let view = SpaceView(viewModel: viewModel)
        viewModel.view = view
        
        view.modalPresentationStyle = .fullScreen
        controller.present(view, animated: true)
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
