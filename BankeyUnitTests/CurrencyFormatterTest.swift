//
//  CurrencyFormatterTest.swift
//  BankeyUnitTests
//
//  Created by yeonBlue on 2022/03/02.
//

import Foundation
import XCTest
@testable import Bankey

class CurrencyFormatterTest: XCTestCase {
    var formatter: CurrencyFormatter!
    
    override func setUp() {
        super.setUp()
        formatter = CurrencyFormatter()
    }
    
    func testBreakDollarsIntoCents() throws {
        let result = formatter.breakIntoDollarsAndCents(123456.78)
        XCTAssertEqual(result.0, "123,456")
        XCTAssertEqual(result.1, "78")
    }
    
    func testDollarsFormatted() throws {
        let result = formatter.dollarsFormatted(123456.78)
        XCTAssertEqual(result, "$123,456.78")
    }
    
    func testZeroDollarsFormatted() throws {
        let result = formatter.dollarsFormatted(0.00)
        XCTAssertEqual(result, "$0.00")
    }
    
    func testDollarsFormattedWithSymbol() throws {
        formatter.setLocale(identifier: "ko_kr")
        let result = formatter.dollarsFormatted(123456.78)
        XCTAssertEqual(result, "₩123,457") // 센트가 없으므로 반올림
    }
}

// Unit Test
// Documentation에 도움
// 디자인에 도움
