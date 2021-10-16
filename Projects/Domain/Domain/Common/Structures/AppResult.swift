//
//  AppResult.swift
//  Domain
//
//  Created by Ekrem Duvarbasi on 16.10.2021.
//

public enum AppResult<T> {
    case succes(T)
    case error(AppError)
}
