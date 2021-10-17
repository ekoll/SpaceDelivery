//
//  ApiStationRepository.swift
//  93652c41ebc5e7170a98811219ab09e0
//
//  Created by Ekrem Duvarbasi on 17.10.2021.
//

import Domain
import Foundation

class ApiStationRepository: StationRepository {
    
    func loadStations(completion: @escaping QueryCompletion<[SpaceStation]>) {
        let request = URLRequest(url: .init(string: "https://run.mocky.io/v3/e7211664-cbb6-4357-9c9d-f12bf8bab2e2")!)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            switch (data, response, error) {
            case (.none, .none, .some(let error)):
                // TODO: return error
                print("Something happened:", error.localizedDescription)
                break
            case (.some(let data), let response as HTTPURLResponse, .none):
                switch response.statusCode {
                case 200..<300:
                    do {
                        let stations = try JSONDecoder().decode([SpaceStation].self, from: data)
                        completion(.succes(stations))
                    }
                    catch {
                        // TODO: return error
                        print("Error on decode server response:", error.localizedDescription)
                    }
                default:
                    // TODO: return error
                    break
                }
                
            default:
                // TODO: return error
                print("something is wrong with response")
            }
        }
        
        task.resume()
    }
}

extension SpaceStation: Decodable {
    enum CodingKeys: String, CodingKey {
        case name
        case coordinateX
        case coordinateY
        case capacity
        case stock
        case need
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let name = try container.decode(String.self, forKey: .name)
        let x = try container.decode(Double.self, forKey: .coordinateX)
        let y = try container.decode(Double.self, forKey: .coordinateY)
        let capacity = try container.decode(Int64.self, forKey: .capacity)
        let stock = try container.decode(Int64.self, forKey: .stock)
        let need = try container.decode(Int64.self, forKey: .need)
        
        self.init(name: name, coordinate: .init(x: x, y: y), capacity: capacity, stock: stock, need: need, isFavorite: false)
    }
}
