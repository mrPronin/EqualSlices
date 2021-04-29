//
//  Home+ViewModel+Test.swift
//  EqualSlicesTests
//
//  Created by Aleksandr Pronin on 29.04.21.
//

import XCTest
@testable import EqualSlices
import Combine

class HomeViewModelTest: XCTestCase {
    var sut: HomeViewModel!
    var subsciptions: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        sut = Home.ViewModel.Implementation()
        subsciptions = Set<AnyCancellable>()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        subsciptions = nil
    }
    
    func testTotalSlicesIsZero() {
        var result: Bool?
        let promise = expectation(description: "Completion handler invoked")
        sut.output
            .sink {
                result = $0
                promise.fulfill()
            }
            .store(in: &subsciptions)
        sut.totalSlices.send("0")
        sut.recipients.send("1")
        sut.perRecipientSlices.send("1")
        wait(for: [promise], timeout: 5)
        XCTAssertNotNil(result)
        XCTAssertEqual(result, false)
    }
    
    func testRecipientsIsZero() {
        var result: Bool?
        let promise = expectation(description: "Completion handler invoked")
        sut.output
            .sink {
                result = $0
                promise.fulfill()
            }
            .store(in: &subsciptions)
        sut.totalSlices.send("1")
        sut.recipients.send("0")
        sut.perRecipientSlices.send("1")
        wait(for: [promise], timeout: 5)
        XCTAssertNotNil(result)
        XCTAssertEqual(result, true)
    }
    
    func testPerRecipientSlicesIsZero() {
        var result: Bool?
        let promise = expectation(description: "Completion handler invoked")
        sut.output
            .sink {
                result = $0
                promise.fulfill()
            }
            .store(in: &subsciptions)
        sut.totalSlices.send("1")
        sut.recipients.send("1")
        sut.perRecipientSlices.send("0")
        wait(for: [promise], timeout: 5)
        XCTAssertNotNil(result)
        XCTAssertEqual(result, true)
    }
    
    func testNotUseEntirePie() {
        var result: Bool?
        let promise = expectation(description: "Completion handler invoked")
        sut.output
            .sink {
                result = $0
                promise.fulfill()
            }
            .store(in: &subsciptions)
        sut.totalSlices.send("10")
        sut.recipients.send("5")
        sut.perRecipientSlices.send("2")
        wait(for: [promise], timeout: 5)
        XCTAssertNotNil(result)
        XCTAssertEqual(result, true)
    }
    
    func testNotEnoughSlices() {
        var result: Bool?
        let promise = expectation(description: "Completion handler invoked")
        sut.output
            .sink {
                result = $0
                promise.fulfill()
            }
            .store(in: &subsciptions)
        sut.totalSlices.send("11")
        sut.recipients.send("5")
        sut.perRecipientSlices.send("3")
        wait(for: [promise], timeout: 5)
        XCTAssertNotNil(result)
        XCTAssertEqual(result, false)
    }
    
    func testExactAmountOfSlices() {
        var result: Bool?
        let promise = expectation(description: "Completion handler invoked")
        sut.output
            .sink {
                result = $0
                promise.fulfill()
            }
            .store(in: &subsciptions)
        sut.totalSlices.send("24")
        sut.recipients.send("12")
        sut.perRecipientSlices.send("2")
        wait(for: [promise], timeout: 5)
        XCTAssertNotNil(result)
        XCTAssertEqual(result, true)
    }
}
