//
//  KeyInfoManager.swift
//  ColdKeySwift
//
//  Created by Huang Yu on 7/29/15.
//  Copyright (c) 2015 BitGo, Inc. All rights reserved.
//

import UIKit

protocol KeyInfoManagerDelegate {
    func didGenerate()
    func didReset()
}

class KeyInfoManager: NSObject {
    private(set) var keyInfo: KeyInfo = KeyInfo()
    
    var delegate: KeyInfoManagerDelegate?
    
    static let sharedManager = KeyInfoManager()
    
    func generate() {
        var mnemonic = NYMnemonic.generateMnemonicString(128 as NSNumber, language: "english")
        self.keyInfo = KeyInfo(mnemonic: mnemonic)
        if let delegate = self.delegate {
            delegate.didGenerate()
        }
    }
    
    func reset() {
        self.keyInfo = KeyInfo(mnemonic: "", publicKey: "", privateKey: "")
        if let delegate = self.delegate {
            delegate.didReset()
        }
    }
}
