//
//  FileFavoriteStationRepository.swift
//  93652c41ebc5e7170a98811219ab09e0
//
//  Created by Ekrem Duvarbasi on 17.10.2021.
//

import Domain
import Foundation

class FileFavoriteStationRepository: FavoriteStationRepository {
    let fileUrl: URL?
    let queue: DispatchQueue = DispatchQueue(label: "database", qos: .background)
    let responseQueue: DispatchQueue
    private var stations: [FavoriteStation] = []
    
    init(fileName: String, responseQueue: DispatchQueue) {
        self.responseQueue = responseQueue
        self.fileUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(fileName)
    }
    
    func loadStations(completion: @escaping (AppResult<[FavoriteStation]>) -> Void) {
        guard let fileUrl = fileUrl else {
            completion(.error(DomainError.couldNotFindFile))
            return
        }

        queue.async {
            do {
                let data = try Data(contentsOf: fileUrl)
                let stations = try JSONDecoder().decode([FavoriteStation].self, from: data)
                self.stations = stations
                
                self.responseQueue.async {
                    completion(.succes(stations))
                }
            }
            catch {
                self.responseQueue.async {
                    completion(.error(CustomError(message: error.localizedDescription)))
                }
            }
        }
    }
    
    func append(station: FavoriteStation, completion: @escaping (AppError?) -> Void) {
        queue.async {
            self.stations.append(station)
            
            self.responseQueue.async {
                completion(nil)
            }
        }
        save()
    }
    
    func remove(station: FavoriteStation, completion: @escaping (AppError?) -> Void) {
        queue.async {
            self.stations.removeAll(where: { $0 == station })
            self.responseQueue.async {
                completion(nil)
            }
        }
        save()
    }
    
    func update(station: FavoriteStation) {
        queue.async {
            guard let index = self.stations.firstIndex(where: { $0 == station }) else { return }
            self.stations[index] = station
        }
        save()
    }
    
    func save() {
        queue.async {
            do {
                guard let fileUrl = self.fileUrl else { return }
                let data = try JSONEncoder().encode(self.stations)
                try data.write(to: fileUrl)
            }
            catch {
                print("Error on saving favorites:", error.localizedDescription)
            }
        }
    }
}

extension FileFavoriteStationRepository {
    enum DomainError: String, AppError {
        case couldNotFindFile = "Could not find file"
        
        var message: String { rawValue }
    }
    
    struct CustomError: AppError {
        var message: String
    }
}

extension FavoriteStation: Codable {
    enum CodingKeys: String, CodingKey {
        case name, coordinate
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let name = try container.decode(String.self, forKey: .name)
        let coordinate = try container.decode(Coordinate.self, forKey: .coordinate)
        
        self.init(name: name, coordinate: coordinate)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(name, forKey: .name)
        try container.encode(coordinate, forKey: .coordinate)
    }
}

extension Coordinate: Codable {
    enum CodingKeys: String, CodingKey {
        case x, y
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let x = try container.decode(Double.self, forKey: .x)
        let y = try container.decode(Double.self, forKey: .y)
        
        self.init(x: x, y: y)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(x, forKey: .x)
        try container.encode(y, forKey: .y)
    }
}
