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
    var mockManager: MockProfileManager!

    class MockProfileManager: ProfileManageable {

        var profile: Profile?
        var error: NetworkError?

        func fetchProfile(
            forUserId userId: String,
            completion: @escaping (Result<Profile, NetworkError>) -> Void
        ) {
            if let error = error {
                completion(.failure(error))

                return
            }

            profile = Profile(id: "1", firstName: "Edwin", lastName: "Cardenas")

            completion(.success(profile!))
        }

    }

    override func setUp() {
        super.setUp()

        vc = AccountSummaryViewController()
        // vc.loadViewIfNeeded() // triggers the view controller's view lifecycle

        mockManager = MockProfileManager()
        vc.profileManager = mockManager
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

    func testAlertForServerError() throws {
        mockManager.error = .serverError
        vc.fetchProfileForTesting()

        XCTAssertEqual("Server Error", vc.alertController.title)
        XCTAssertEqual(
            "Ensure you are connected to the Internet. Please try again.",
            vc.alertController.message
        )
    }

    func testAlertForDecodingError() throws {
        mockManager.error = .decodingError
        vc.fetchProfileForTesting()

        XCTAssertEqual("Decoding Error", vc.alertController.title)
        XCTAssertEqual(
            "We could not process your request. Please try again.",
            vc.alertController.message
        )
    }

}
