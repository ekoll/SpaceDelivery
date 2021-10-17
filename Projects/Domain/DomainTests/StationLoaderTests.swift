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
        let loader = StationLoader(repository: repository, favouriteRepository: FakeFavoriteStationRepository())
        
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
        let loader = StationLoader(repository: repository, favouriteRepository: FakeFavoriteStationRepository())
        
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
        let loader = StationLoader(repository: repository, favouriteRepository: FakeFavoriteStationRepository())
        
        loader.loadStations { result in
            switch result {
            case .succes:
                XCTAssert(false, "There must be error")
            default: break
            }
        }
    }
    
    // MARK: load favorites
    func test_success_load_favourites() {
        let repository = FakeFavoriteStationRepository(stationsResult: .succes([]))
        let loader = StationLoader(repository: FakeStationRepository(), favouriteRepository: repository)
        
        loader.loadFavoriteStations { result in
            switch result {
            case .error(let error):
                XCTAssert(false, "Error: \(error.message)")
            default: break
            }
        }
    }
    
    func test_success_with_true_favourites() {
        let givenStations: [FavoriteStation] = [
            .init(name: "Test1", coordinate: .zero),
            .init(name: "Test2", coordinate: .zero),
            .init(name: "Test3", coordinate: .zero)
        ]
        let repository = FakeFavoriteStationRepository(stationsResult: .succes(givenStations))
        let loader = StationLoader(repository: FakeStationRepository(), favouriteRepository: repository)
        
        loader.loadFavoriteStations { result in
            switch result {
            case .error(let error):
                XCTAssert(false, "Error: \(error.message)")
            case .succes(let stations):
                XCTAssertEqual(stations, givenStations)
            }
        }
    }
    
    func test_failure_on_load_favourite_stations() throws {
        let repository = FakeFavoriteStationRepository(stationsResult: .error(FakeError()))
        let loader = StationLoader(repository: FakeStationRepository(), favouriteRepository: repository)
        
        loader.loadFavoriteStations { result in
            switch result {
            case .succes:
                XCTAssert(false, "There must be error")
            default: break
            }
        }
    }
    
    // MARK: append favorite
    func test_append_favorite_station() {
        let repository = FakeFavoriteStationRepository(appendStation: { _ in nil })
        let loader = StationLoader(repository: FakeStationRepository(), favouriteRepository: repository)
        
        
        loader.appendStationToFavorites(.init(isFavorite: false)) { result in
            switch result {
            case .error(let error):
                XCTAssert(false, "Error: \(error.message)")
            default: break
            }
        }
    }
    
    func test_append_already_favourite_station() throws {
        let repository = FakeFavoriteStationRepository(removeStation: { _ in
            XCTAssert(false, "StationLoader must not call repository for this case")
            return nil
        })
        let loader = StationLoader(repository: FakeStationRepository(), favouriteRepository: repository)
        
        let givenStation = SpaceStation(isFavorite: true)
        loader.appendStationToFavorites(givenStation) { result in
            switch result {
            case .succes(let station):
                XCTAssertEqual(station, givenStation)
            default: break
            }
        }
    }
    
    func test_add_station_saves_true_value() {
        let expectedStation = FavoriteStation(name: "Test", coordinate: .init(x: 5, y: 4))
        
        let repository = FakeFavoriteStationRepository(appendStation: { station in
            XCTAssertEqual(station, expectedStation)
            return nil
        })
    
        let loader = StationLoader(repository: FakeStationRepository(), favouriteRepository: repository)
        
        let givenStation = SpaceStation(name: "Test", coordinate: .init(x: 5, y: 4))
        loader.appendStationToFavorites(givenStation) { _ in }
    }
    
    func test_failure_on_append_favourite_station() throws {
        let repository = FakeFavoriteStationRepository(appendStation: { _ in FakeError() })
        let loader = StationLoader(repository: FakeStationRepository(), favouriteRepository: repository)
        
        loader.appendStationToFavorites(.init()) { result in
            switch result {
            case .succes:
                XCTAssert(false, "There must be error")
            default: break
            }
        }
    }
    
    // MARK: remove favorite
    func test_remove_station() {
        let repository = FakeFavoriteStationRepository(removeStation: { _ in nil })
        let loader = StationLoader(repository: FakeStationRepository(), favouriteRepository: repository)
        
        
        loader.removeStationFromFavorites(.init(isFavorite: true)) { result in
            switch result {
            case .error(let error):
                XCTAssert(false, "Error: \(error.message)")
            default: break
            }
        }
    }
    
    func test_remove_station_removes_true_value() {
        let expectedStation = FavoriteStation(name: "Test", coordinate: .init(x: 5, y: 4))
        
        let repository = FakeFavoriteStationRepository(removeStation: { station in
            XCTAssertEqual(station, expectedStation)
            return nil
        })
    
        let loader = StationLoader(repository: FakeStationRepository(), favouriteRepository: repository)
        
        let givenStation = SpaceStation(name: "Test", coordinate: .init(x: 5, y: 4), isFavorite: true)
        loader.removeStationFromFavorites(givenStation) { _ in }
    }
    
    func test_failure_on_remove_favourite_station() throws {
        let repository = FakeFavoriteStationRepository(removeStation: { _ in FakeError() })
        let loader = StationLoader(repository: FakeStationRepository(), favouriteRepository: repository)
        
        loader.removeStationFromFavorites(.init(isFavorite: true)) { result in
            switch result {
            case .succes:
                XCTAssert(false, "There must be error")
            default: break
            }
        }
    }
    
    func test_remove_non_favourite_station() throws {
        let repository = FakeFavoriteStationRepository(removeStation: { _ in
            XCTAssert(false, "StationLoader must not call repository for this case")
            return nil
        })
        let loader = StationLoader(repository: FakeStationRepository(), favouriteRepository: repository)
        
        let givenStation = SpaceStation(isFavorite: false)
        loader.removeStationFromFavorites(givenStation) { result in
            switch result {
            case .succes(let station):
                XCTAssertEqual(station, givenStation)
            default: break
            }
        }
    }
    
    // MARK: update favorite
    func test_update_station_updates_true_value() {
        let givenStation = FavoriteStation(name: "Test", coordinate: .init(x: 5, y: 4))
        
        let repository = FakeFavoriteStationRepository(updateStation: { station in
            XCTAssertEqual(station, givenStation)
        })
    
        let loader = StationLoader(repository: FakeStationRepository(), favouriteRepository: repository)
        loader.updateCordinate(for: givenStation)
    }
    
    // MARK: merging stations with favourite
    func test_stations_marked_favourite() {
        let stationRepository = FakeStationRepository(stationsResult: .succes([
            .init(name: "Test1"),
            .init(name: "Test2"),
            .init(name: "Test3"),
            .init(name: "Test4"),
            .init(name: "Test5"),
        ]))
        
        let favoriteStationRepository = FakeFavoriteStationRepository(stationsResult: .succes([
            .init(name: "Test1", coordinate: .zero),
            .init(name: "Test4", coordinate: .zero)
        ]))
        
        let loader = StationLoader(repository: stationRepository, favouriteRepository: favoriteStationRepository)
        
        
        let expectedStations: [SpaceStation] = [
            .init(name: "Test1"),
            .init(name: "Test2"),
            .init(name: "Test3"),
            .init(name: "Test4"),
            .init(name: "Test5"),
        ]
        
        loader.loadStations { result in
            switch result {
            case .succes(let stations):
                XCTAssertEqual(stations, expectedStations)
                XCTAssertEqual(stations[0].isFavorite, true)
                XCTAssertEqual(stations[1].isFavorite, false)
                XCTAssertEqual(stations[2].isFavorite, false)
                XCTAssertEqual(stations[3].isFavorite, true)
                XCTAssertEqual(stations[4].isFavorite, false)
                
            case .error(let error):
                XCTAssert(false, "There must not be error: \(error.message)")
            }
        }
    }
    
    func test_load_stations_not_return_error_when_favorites_return_error() {
        let stationRepository = FakeStationRepository(stationsResult: .succes([]))
        let favoriteStationRepository = FakeFavoriteStationRepository(stationsResult: .error(FakeError()))
        let loader = StationLoader(repository: stationRepository, favouriteRepository: favoriteStationRepository)
        
        loader.loadStations { result in
            switch result {
            case .succes:
                break
            case .error(let error):
                XCTAssert(false, "There must not be error: \(error.message)")
            }
        }
    }
}
