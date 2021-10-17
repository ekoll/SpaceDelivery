//
//  _3652c41ebc5e7170a98811219ab09e0UITestsLaunchTests.swift
//  93652c41ebc5e7170a98811219ab09e0UITests
//
//  Created by Ekrem Duvarbasi on 17.10.2021.
//

import XCTest

class _3652c41ebc5e7170a98811219ab09e0UITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
