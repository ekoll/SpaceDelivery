//
//  AppLoadViewModelTests.swift
//  PresentationTests
//
//  Created by Ekrem Duvarbasi on 17.10.2021.
//

import XCTest
@testable import Presentation

class AppLoadViewModelTests: XCTestCase {

    func test_on_success_is_router_called() throws {
        let fakeLoader = FakeStationLoader(loadStations: .succes([]))
        let mockRouter = FakeAppLoadRouter(presentSpaceshipBuild: { _ in
            XCTAssert(true)
        })
        
        let viewModel = AppLoadViewModel(useCase: fakeLoader, router: mockRouter, view: FakeRenderer())
        
        viewModel.start()
    }
    
    func test_on_error_is_view_called() throws {
        let fakeLoader = FakeStationLoader(loadStations: .error(FakeError()))
        let mockView = FakeRenderer(error: { _ in
            XCTAssert(true)
        })
        
        let viewModel = AppLoadViewModel(useCase: fakeLoader, router: FakeAppLoadRouter(), view: mockView)
        
        viewModel.start()
    }
}
