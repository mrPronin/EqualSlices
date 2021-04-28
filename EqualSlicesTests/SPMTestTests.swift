//
//  SPMTestTests.swift
//  SPMTestTests
//
//  Created by Aleksandr Pronin on 27.04.21.
//

import XCTest
@testable import EqualSlices

class SPMTestTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTotalSlicesIsZero() {
        let testTotalSlicesIsZero = equalSlices(totalSlices: 0, recipients: 1, perRecipientSlices: 1)
        XCTAssertEqual(testTotalSlicesIsZero, false)
    }
    
    func testRecipientsIsZero() {
        let testRecipientsIsZero = equalSlices(totalSlices: 1, recipients: 0, perRecipientSlices: 1)
        XCTAssertEqual(testRecipientsIsZero, true)
    }
    
    func testPerRecipientSlicesIsZero() {
        let testPerRecipientSlicesIsZero = equalSlices(totalSlices: 1, recipients: 1, perRecipientSlices: 0)
        XCTAssertEqual(testPerRecipientSlicesIsZero, true)
    }
    
    func testNotUseEntirePie() {
        let testNotUseEntirePie = equalSlices(totalSlices: 10, recipients: 5, perRecipientSlices: 2)
        XCTAssertEqual(testNotUseEntirePie, true)
    }
    
    func testNotEnoughSlices() {
        let testNotEnoughSlices = equalSlices(totalSlices: 11, recipients: 5, perRecipientSlices: 3)
        XCTAssertEqual(testNotEnoughSlices, false)
    }
    
    func testExactAmountOfSlices() {
        let testExactAmountOfSlices = equalSlices(totalSlices: 24, recipients: 12, perRecipientSlices: 2)
        XCTAssertEqual(testExactAmountOfSlices, true)
    }
}
