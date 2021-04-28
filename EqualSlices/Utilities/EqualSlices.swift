//
//  EqualSlices.swift
//  SPMTest
//
//  Created by Aleksandr Pronin on 27.04.21.
//

import Foundation

func equalSlices(totalSlices: Int, recipients: Int, perRecipientSlices slices: Int) -> Bool {
    guard recipients >= 0 else { return true }
    return totalSlices >= recipients * slices
}
