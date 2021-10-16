//
//  StationLoader.swift
//  Domain
//
//  Created by Ekrem Duvarbasi on 16.10.2021.
//

public class StationLoader: LoadStationUseCase {
    private let repository: StationRepository
    
    public init(repository: StationRepository) {
        self.repository = repository
    }
    
    public func loadStations(completion: @escaping QueryCompletion<[SpaceStation]>) {
        repository.loadStations(completion: completion)
    }
}
