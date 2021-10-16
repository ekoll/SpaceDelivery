//
//  StationLoaderTests.swift
//  DomainTests
//
//  Created by Ekrem Duvarbasi on 16.10.2021.
//

import XCTest

class StationLoaderTests: XCTestCase {

    // MARK: load stations
    func test_success() throws {
        let repository = FakeStationRepository(stationsResult: .succes([]))
        let loader = StationLoader(repository: repository, favouriteRepository: FakeFavouriteStationRepository())
        
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
        let loader = StationLoader(repository: repository, favouriteRepository: FakeFavouriteStationRepository())
        
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
        let loader = StationLoader(repository: repository, favouriteRepository: FakeFavouriteStationRepository())
        
        loader.loadStations { result in
            switch result {
            case .succes:
                XCTAssert(false, "There must be error")
            default: break
            }
        }
    }
    
    // MARK: load favourites
    func test_success_load_favourites() {
        let repository = FakeFavouriteStationRepository(stationsResult: .succes([]))
        let loader = StationLoader(repository: FakeStationRepository(), favouriteRepository: repository)
        
        loader.loadFavouriteStations { result in
            switch result {
            case .error(let error):
                XCTAssert(false, "Error: \(error.message)")
            default: break
            }
        }
    }
    
    func test_success_with_true_favourites() {
        let givenStations: [FavouriteStation] = [
            .init(name: "Test1", coordinate: .zero),
            .init(name: "Test2", coordinate: .zero),
            .init(name: "Test3", coordinate: .zero)
            
        ]
        let repository = FakeFavouriteStationRepository(stationsResult: .succes(givenStations))
        let loader = StationLoader(repository: FakeStationRepository(), favouriteRepository: repository)
        
        loader.loadFavouriteStations { result in
            switch result {
            case .error(let error):
                XCTAssert(false, "Error: \(error.message)")
            case .succes(let stations):
                XCTAssertEqual(stations, givenStations)
            }
        }
    }
    
    func test_failure_on_load_favourite_stations() throws {
        let repository = FakeFavouriteStationRepository(stationsResult: .error(FakeError()))
        let loader = StationLoader(repository: FakeStationRepository(), favouriteRepository: repository)
        
        loader.loadFavouriteStations { result in
            switch result {
            case .succes:
                XCTAssert(false, "There must be error")
            default: break
            }
        }
    }
    
    // MARK: append favourite
    func test_append_station() {
        let repository = FakeFavouriteStationRepository(appendStation: { _ in nil })
        let loader = StationLoader(repository: FakeStationRepository(), favouriteRepository: repository)
        
        
        loader.append(favouriteStation: .init(name: "", coordinate: .zero)) { error in
            switch error {
            case .some(let error):
                XCTAssert(false, "Error: \(error.message)")
            default: break
            }
        }
    }
    
    func test_add_station_does_not_manipulate() {
        let givenStation = FavouriteStation(name: "Test", coordinate: .zero)
        
        let repository = FakeFavouriteStationRepository(appendStation: { station in
            XCTAssertEqual(station, givenStation)
            return nil
        })
        let loader = StationLoader(repository: FakeStationRepository(), favouriteRepository: repository)
        
        
        loader.append(favouriteStation: givenStation) { _ in }
    }
    
    func test_failure_on_append_favourite_station() throws {
        let repository = FakeFavouriteStationRepository(appendStation: { _ in FakeError() })
        let loader = StationLoader(repository: FakeStationRepository(), favouriteRepository: repository)
        
        loader.append(favouriteStation: .init(name: "", coordinate: .zero)) { error in
            switch error {
            case .none:
                XCTAssert(false, "There must be error")
            default: break
            }
        }
    }
    
    // MARK: remove favourite
    func test_remove_station() {
        let repository = FakeFavouriteStationRepository(removeStation: { _ in nil })
        let loader = StationLoader(repository: FakeStationRepository(), favouriteRepository: repository)
        
        
        loader.remove(favouriteStation: .init(name: "", coordinate: .zero)) { error in
            switch error {
            case .some(let error):
                XCTAssert(false, "Error: \(error.message)")
            default: break
            }
        }
    }
    
    func test_remove_station_does_not_manipulate() {
        let givenStation = FavouriteStation(name: "Test", coordinate: .zero)
        
        let repository = FakeFavouriteStationRepository(removeStation: { station in
            XCTAssertEqual(station, givenStation)
            return nil
        })
        let loader = StationLoader(repository: FakeStationRepository(), favouriteRepository: repository)
        
        
        loader.remove(favouriteStation: givenStation) { _ in }
    }
    
    func test_failure_on_remove_favourite_station() throws {
        let repository = FakeFavouriteStationRepository(removeStation: { _ in FakeError() })
        let loader = StationLoader(repository: FakeStationRepository(), favouriteRepository: repository)
        
        loader.remove(favouriteStation: .init(name: "", coordinate: .zero)) { error in
            switch error {
            case .none:
                XCTAssert(false, "There must be error")
            default: break
            }
        }
    }
}
