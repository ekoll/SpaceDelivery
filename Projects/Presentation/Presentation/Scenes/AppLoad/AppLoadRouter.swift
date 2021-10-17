//
//  AppLoadRouter.swift
//  Presentation
//
//  Created by Ekrem Duvarbasi on 17.10.2021.
//

import Domain

public protocol AppLoadRouter {
    func presentSpaceshipBuild(stations: [SpaceStation])
}
