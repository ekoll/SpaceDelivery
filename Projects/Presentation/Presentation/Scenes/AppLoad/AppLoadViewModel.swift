//
//  AppLoadViewModel.swift
//  Presentation
//
//  Created by Ekrem Duvarbasi on 17.10.2021.
//

import Domain
import Foundation

public class AppLoadViewModel {
    private let useCase: LoadStationUseCase
    private let router: AppLoadRouter
    private weak var view: Renderer?
    
    public init(useCase: LoadStationUseCase, router: AppLoadRouter, view: Renderer) {
        self.useCase = useCase
        self.router = router
        self.view = view
    }
    
    public func start() {
        useCase.loadStations { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .succes(let stations):
                self.router.presentSpaceshipBuild(stations: stations)
            case .error(let error):
                self.view?.present(error: error.message)
            }
        }
    }
}
