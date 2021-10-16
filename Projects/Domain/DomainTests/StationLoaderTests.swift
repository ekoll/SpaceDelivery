//
//  StationLoaderTests.swift
//  DomainTests
//
//  Created by Ekrem Duvarbasi on 16.10.2021.
//

import XCTest

class StationLoaderTests: XCTestCase {

    func test_success() throws {
        let repository = FakeStationRepository(stationsResult: .succes([]))
        let loader = StationLoader(repository: repository)
        
        loader.loadStations { result in
            switch result {
            case .error(let error):
                XCTAssert(false, "Error: \(error.message)")
            default: break
            }
        }
    }
    
    func test_success_with_true_stations() {
        let givenStations: [SpaceStation] = [
            .init(name: "Test1", coordinate: .init(x: 0, y: 0), capacity: 0, stock: 0, need: 0),
            .init(name: "Test2", coordinate: .init(x: 1, y: 2), capacity: 0, stock: 0, need: 0),
            .init(name: "Test3", coordinate: .init(x: 1, y: 2), capacity: 0, stock: 0, need: 0)
        ]
        let repository = FakeStationRepository(stationsResult: .succes(givenStations))
        let loader = StationLoader(repository: repository)
        
        loader.loadStations { result in
            switch result {
            case .error(let error):
                XCTAssert(false, "Error: \(error.message)")
            case .succes(let stations):
                XCTAssertEqual(stations, givenStations)
            }
        }
    }
    
    func test_failure() throws {
        let repository = FakeStationRepository(stationsResult: .error(FakeError()))
        let loader = StationLoader(repository: repository)
        
        loader.loadStations { result in
            switch result {
            case .succes:
                XCTAssert(false, "There must be error")
            default: break
            }
        }
    }
}
