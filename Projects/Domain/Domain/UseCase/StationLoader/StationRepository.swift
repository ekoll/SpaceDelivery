//
//  StationRepository.swift
//  Domain
//
//  Created by Ekrem Duvarbasi on 16.10.2021.
//

public protocol StationRepository {
    func loadStations(completion: @escaping QueryCompletion<[SpaceStation]>)
}
