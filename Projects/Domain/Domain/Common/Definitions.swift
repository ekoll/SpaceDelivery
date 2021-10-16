//
//  Definitions.swift
//  Domain
//
//  Created by Ekrem Duvarbasi on 16.10.2021.
//

import Foundation

public typealias CommandCompletion = (AppError?) -> Void
public typealias QueryCompletion<T> = (AppResult<T>) -> Void
