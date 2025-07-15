//
//  CurrencyFormatterTests.swift
//  BankeyUnitTests
//
//  Created by Edwin Cardenas on 7/3/25.
//

import Foundation
import XCTest

@testable import Bankey

class Test: XCTestCase {
    var formatter: CurrencyFormatter!

    override func setUp() {
        super.setUp()

        formatter = CurrencyFormatter()
    }

    func testBreakDollarsIntoCents() throws {
        let result = formatter.breakIntoDollarsAndCents(929466.23)

        XCTAssertEqual(result.dollars, "929,466")
        XCTAssertEqual(result.cents, "23")
    }

    func testDollarsFormatted() throws {
        let result = formatter.dollarsFormatted(929466.23)

        XCTAssertEqual(result, "$929,466.23")
    }

    func testZeroDollarsFormatted() throws {
        let result = formatter.dollarsFormatted(0)

        XCTAssertEqual(result, "$0.00")
    }
}
