//
//  LoadStationUseCase.swift
//  Domain
//
//  Created by Ekrem Duvarbasi on 16.10.2021.
//


public protocol LoadStationUseCase {
    func loadStations(completion: @escaping QueryCompletion<[SpaceStation]>)
}
