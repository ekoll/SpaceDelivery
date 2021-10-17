//
//  FakeError.swift
//  PresentationTests
//
//  Created by Ekrem Duvarbasi on 17.10.2021.
//

import Domain

struct FakeError: AppError {
    var message: String { "Fake Error" }
}
