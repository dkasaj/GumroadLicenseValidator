//
//  GumroadLicenseCheckTests.swift
//  GumroadLicenseCheckTests
//
//  Created by Daniel Kasaj on 07.01.2022..
//

import XCTest
@testable import GumroadLicenseValidator

class GumroadLicenseCheckTests: XCTestCase {

    let testProductPermalink = "------" // Enter yours!
    let testLicenseKey = "XXXXXXXX-XXXXXXXX-XXXXXXXX-XXXXXXXX" // Enter yours!

    var sut: GumroadClient?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        sut = GumroadClient(productPermalink: testProductPermalink)
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_canInit() {
        XCTAssertNotNil(GumroadClient(productPermalink: testProductPermalink))

        XCTAssertNil(GumroadClient(productPermalink: ""))
    }

    func test_canMakeAPIURLRequest() async {
        let request = sut?.makeRequest(licenseKey: testLicenseKey)
        XCTAssertNotNil(request)

        let requestWithoutLicenseKey = sut?.makeRequest(licenseKey: "")
        XCTAssertNil(requestWithoutLicenseKey)
    }

    func test_canVerifyLicense() async throws {
        let result = await sut?.isLicenseKeyValid(testLicenseKey)
        XCTAssertTrue(try XCTUnwrap(result))

        let invalidResult = await sut?.isLicenseKeyValid("not-a-valid-key")
        XCTAssertFalse(try XCTUnwrap(invalidResult))
    }
}
