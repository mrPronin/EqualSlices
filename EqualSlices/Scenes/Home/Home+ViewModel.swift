//
//  Home+ViewModel.swift
//  EqualSlices
//
//  Created by Aleksandr Pronin on 29.04.21.
//

import Foundation
import Combine
import EqualSlicesPackage

protocol HomeViewModel {
    var totalSlices: PassthroughSubject<String, Never> { get }
    var recipients: PassthroughSubject<String, Never> { get }
    var perRecipientSlices: PassthroughSubject<String, Never> { get }
    var output: PassthroughSubject<Bool, Never> { get }
}

extension Home { enum ViewModel {} }

extension Home.ViewModel {
    class Implementation: HomeViewModel {
        // MARK: - Public
        let totalSlices = PassthroughSubject<String, Never>()
        let recipients = PassthroughSubject<String, Never>()
        let perRecipientSlices = PassthroughSubject<String, Never>()
        let output = PassthroughSubject<Bool, Never>()
        
        // MARK: - Init
        init() {
            totalSlices.combineLatest(recipients, perRecipientSlices)
                .sink { [weak self] in
                    guard let totalSlices = Int($0.0) else { return }
                    guard let recipients = Int($0.1) else { return }
                    guard let perRecipientSlices = Int($0.2) else { return }
                    let result = equalSlices(totalSlices: totalSlices, recipients: recipients, perRecipientSlices: perRecipientSlices)
                    self?.output.send(result)
                }.store(in: &subsciptions)
        }
        // MARK: - Private
        var subsciptions = Set<AnyCancellable>()
    }
}
