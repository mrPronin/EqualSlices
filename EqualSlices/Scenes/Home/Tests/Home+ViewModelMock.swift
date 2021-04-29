//
//  Home+ViewModelMock.swift
//  EqualSlicesTests
//
//  Created by Aleksandr Pronin on 29.04.21.
//

import XCTest
@testable import EqualSlices
import Combine

extension Home.ViewModel {
    struct Mock: HomeViewModel {
        let totalSlices = PassthroughSubject<String, Never>()
        let recipients = PassthroughSubject<String, Never>()
        let perRecipientSlices = PassthroughSubject<String, Never>()
        let output = PassthroughSubject<Bool, Never>()
    }
}
