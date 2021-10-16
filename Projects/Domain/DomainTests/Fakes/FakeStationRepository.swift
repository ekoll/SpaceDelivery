//
//  FakeStationRepository.swift
//  DomainTests
//
//  Created by Ekrem Duvarbasi on 16.10.2021.
//

struct FakeStationRepository: StationRepository {
    var stationsResult: AppResult<[SpaceStation]>
    
    func loadStations(completion: @escaping QueryCompletion<[SpaceStation]>) {
        completion(stationsResult)
    }
}
