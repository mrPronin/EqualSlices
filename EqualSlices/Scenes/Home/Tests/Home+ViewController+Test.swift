//
//  Home+ViewController+Test.swift
//  EqualSlicesTests
//
//  Created by Aleksandr Pronin on 29.04.21.
//

import XCTest
@testable import EqualSlices
import Combine

class HomeViewControllerTest: XCTestCase {
    var sut: Home.ViewController!
    var viewModel: HomeViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = Home.ViewModel.Mock()
        sut = Home.ViewController(viewModel: viewModel)
        UIView.performWithoutAnimation {
            let window = UIWindow()
            window.rootViewController = sut
            window.makeKeyAndVisible()
        }
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        viewModel = nil
    }
    
    func testInstantiateViewController() {
        XCTAssertNotNil(sut.view)
    }
    
    func testUICreated() {
        XCTAssertEqual(sut.stackView.subviews.count, 4)
    }
}
