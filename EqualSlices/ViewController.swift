//
//  ViewController.swift
//  SPMTest
//
//  Created by Aleksandr Pronin on 27.04.21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let testTotalSlicesIsZero = equalSlices(totalSlices: 0, recipients: 1, perRecipientSlices: 1)
        print("testTotalSlicesIsZero: \(testTotalSlicesIsZero)")
        
        let testRecipientsIsZero = equalSlices(totalSlices: 1, recipients: 0, perRecipientSlices: 1)
        print("testRecipientsIsZero: \(testRecipientsIsZero)")
        
        let testPerRecipientSlicesIsZero = equalSlices(totalSlices: 1, recipients: 1, perRecipientSlices: 0)
        print("testPerRecipientSlicesIsZero: \(testPerRecipientSlicesIsZero)")
        
        let testNotUseEntirePie = equalSlices(totalSlices: 11, recipients: 5, perRecipientSlices: 2)
        print("testNotUseEntirePie: \(testNotUseEntirePie)")
        
        let testNotEnoughSlices = equalSlices(totalSlices: 11, recipients: 5, perRecipientSlices: 3)
        print("testNotEnoughSlices: \(testNotEnoughSlices)")
        
        
        let testExactAmountOfSlices = equalSlices(totalSlices: 24, recipients: 12, perRecipientSlices: 2)
        print("testExactAmountOfSlices: \(testExactAmountOfSlices)")

    }


}

