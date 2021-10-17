//
//  FilterableStationsTests.swift
//  Presentation
//
//  Created by Ekrem Duvarbasi on 17.10.2021.
//

import XCTest
import Domain

@testable import Presentation

class FilterableStationsTests: XCTestCase {
    var stations: FilterableStations = .init(stations: [
        .init(station: SpaceStation(name: "Mercury", isFavorite: false), shipLocation: .init(name: "", coorditnate: .zero)),
        .init(station: SpaceStation(name: "Venus", isFavorite: false), shipLocation: .init(name: "", coorditnate: .zero)),
        .init(station: SpaceStation(name: "World", isFavorite: true), shipLocation: .init(name: "", coorditnate: .zero)),
        .init(station: SpaceStation(name: "Mars", isFavorite: true), shipLocation: .init(name: "", coorditnate: .zero)),
        .init(station: SpaceStation(name: "Jupiter", isFavorite: false), shipLocation: .init(name: "", coorditnate: .zero)),
        .init(station: SpaceStation(name: "Saturn", isFavorite: false), shipLocation: .init(name: "", coorditnate: .zero)),
        .init(station: SpaceStation(name: "Uranus", isFavorite: false), shipLocation: .init(name: "", coorditnate: .zero)),
        .init(station: SpaceStation(name: "Neptun", isFavorite: false), shipLocation: .init(name: "", coorditnate: .zero)),
        .init(station: SpaceStation(name: "Pluton", isFavorite: false), shipLocation: .init(name: "", coorditnate: .zero))
    ])
    
    func test_return_all_when_there_is_no_filter() {
        XCTAssertEqual(stations.data.count, 9)
    }
    
    func test_return_just_favourites_when_favourites_true() {
        stations.justFavorites = true
        XCTAssertEqual(stations.data.count, 2)
    }
    
    func test_filter_text() {
        stations.filterText = "rld"
        XCTAssertEqual(stations.data.count, 1)
    }
    
    func test_returns_all_when_filter_text_is_empty() {
        stations.filterText = ""
        XCTAssertEqual(stations.data.count, 9)
    }
    
    func test_filter_text_and_favourite() {
        stations.filterText = "turn"
        stations.justFavorites = true
        XCTAssertEqual(stations.data.count, 0)
    }
}
