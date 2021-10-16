//
//  AppError.swift
//  Domain
//
//  Created by Ekrem Duvarbasi on 16.10.2021.
//

import Foundation

public protocol AppError: Error {
    var message: String { get }
}
