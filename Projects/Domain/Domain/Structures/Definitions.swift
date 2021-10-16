//
//  Definitions.swift
//  Domain
//
//  Created by Ekrem Duvarbasi on 16.10.2021.
//

import Foundation

typealias CommandCompletion = (AppError?) -> Void
typealias QueryCompletion<T> = (AppResult<T>) -> Void
