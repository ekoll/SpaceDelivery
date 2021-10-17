//
//  DependencyContainer.swift
//  93652c41ebc5e7170a98811219ab09e0
//
//  Created by Ekrem Duvarbasi on 17.10.2021.
//

import Foundation

class DependencyContainer {
    private var parent: DependencyContainer?
    private var container: [String: (DependencyContainer) -> Any] = [:]
    
    init(parent: DependencyContainer? = nil) {
        self.parent = parent
    }
    
    func append<T>(type: T.Type, generator: @escaping (DependencyContainer) -> T) {
        container[String(describing: T.self)] = generator
    }
    
    func resolve<T>() -> T {
        guard let object = container[String(describing: T.self)]?(self) else {
            return parent!.resolve()
        }
        
        return object as! T
    }
}
