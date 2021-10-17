//
//  FilterableStations.swift
//  Presentation
//
//  Created by Ekrem Duvarbasi on 17.10.2021.
//

public class FilterableStations {
    private let stations: [StationViewModel]
    private var filtered: [StationViewModel] = []
    
    public var filterText: String? {
        didSet { updateFilter() }
    }
    
    public var justFavorites: Bool = false {
        didSet { updateFilter() }
    }
    
    public var data: [StationViewModel] {
        shouldFilter ? filtered : stations
    }
    
    internal init(stations: [StationViewModel]) {
        self.stations = stations
    }
}

// MARK: - private
private extension FilterableStations {
    
    func updateFilter() {
        guard shouldFilter else { return }
        
        if let text = filterText, !text.isEmpty {
            filtered = stations.filter {
                !(!$0.isFavourite && justFavorites) && $0.name.contains(text)
            }
            return
        }
        
        filtered = stations.filter { !(!$0.isFavourite && justFavorites) }
    }
    
    var shouldFilter: Bool {
        justFavorites || !isFilterTextEmpty
    }
    
    var isFilterTextEmpty: Bool {
        filterText?.isEmpty ?? true
    }
}
