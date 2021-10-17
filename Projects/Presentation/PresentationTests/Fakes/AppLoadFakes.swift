//
//  AppLoadFakes.swift
//  PresentationTests
//
//  Created by Ekrem Duvarbasi on 17.10.2021.
//

import Domain
import Presentation

struct FakeAppLoadRouter: AppLoadRouter {
    var presentSpaceshipBuild: ([SpaceStation]) -> Void = { _ in }
    
    func presentSpaceshipBuild(stations: [SpaceStation]) {
        self.presentSpaceshipBuild(stations)
    }
}

struct FakeStationLoader: LoadStationUseCase {
    var loadStations: AppResult<[SpaceStation]> = .error(FakeError())
    
    func loadStations(completion: @escaping QueryCompletion<[SpaceStation]>) {
        completion(self.loadStations)
    }
}
