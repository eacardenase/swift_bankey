//
//  AccountSummaryViewControllerTests.swift
//  BankeyUnitTests
//
//  Created by Edwin Cardenas on 7/12/25.
//

import XCTest

@testable import Bankey

class AccountSummaryViewControllerTests: XCTestCase {

    var vc: AccountSummaryViewController!

    override func setUp() {
        super.setUp()

        vc = AccountSummaryViewController()
        //        vc.loadViewIfNeeded() // triggers the view controller's view lifecycle
    }

    func testTitleAndMessageForServerError() throws {
        let titleAndMessage = vc.titleAndMessageForTesting(for: .serverError)

        XCTAssertEqual("Server Error", titleAndMessage.title)
        XCTAssertEqual(
            "Ensure you are connected to the Internet. Please try again.",
            titleAndMessage.message
        )
    }

    func testTitleAndMessageForDecodingError() throws {
        let titleAndMessage = vc.titleAndMessageForTesting(for: .decodingError)

        XCTAssertEqual("Decoding Error", titleAndMessage.title)
        XCTAssertEqual(
            "We could not process your request. Please try again.",
            titleAndMessage.message
        )
    }

}
