//
//  ProfileTests.swift
//  BankeyUnitTests
//
//  Created by Edwin Cardenas on 7/8/25.
//

import XCTest

@testable import Bankey

class ProfileTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    func testCanParse() throws {
        let json = """
            {
            "id": "1",
            "first_name": "Kevin",
            "last_name": "Flynn"
            }
            """

        let data = json.data(using: .utf8)!
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        let result = try decoder.decode(Profile.self, from: data)

        XCTAssertEqual(result.id, "1")
        XCTAssertEqual(result.firstName, "Kevin")
        XCTAssertEqual(result.lastName, "Flynn")
    }
}
