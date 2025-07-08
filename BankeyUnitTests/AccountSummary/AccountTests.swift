//
//  AccountTests.swift
//  BankeyUnitTests
//
//  Created by Edwin Cardenas on 7/8/25.
//

import XCTest

@testable import Bankey

class AccountTests: XCTestCase {

    func testCanParse() throws {
        let json = """
            [
            {
             "id": "1",
             "type": "Banking",
             "name": "Basic Savings",
             "amount": 929466.23,
             "createdDateTime" : "2010-06-21T15:29:32Z"
            },
            {
             "id": "2",
             "type": "Banking",
             "name": "No-Fee All-In Chequing",
             "amount": 17562.44,
             "createdDateTime" : "2011-06-21T15:29:32Z"
            }
            ]
            """

        let data = json.data(using: .utf8)!
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        let accounts = try decoder.decode([Account].self, from: data)

        XCTAssertEqual(accounts.count, 2)

        let firstAccount = accounts[0]

        XCTAssertEqual(firstAccount.id, "1")
        XCTAssertEqual(firstAccount.type, .Banking)
        XCTAssertEqual(firstAccount.name, "Basic Savings")
        XCTAssertEqual(firstAccount.amount, 929466.23)
    }

}
