//
//  ShipBuildRouter.swift
//  Presentation
//
//  Created by Ekrem Duvarbasi on 17.10.2021.
//

import Domain
import Foundation

public protocol ShipBuildRouter {
    func presentGame(ship: Spaceship)
}
