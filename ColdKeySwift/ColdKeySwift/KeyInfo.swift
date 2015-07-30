//
//  KeyInfo.swift
//  ColdKey
//
//  Created by Huang Yu on 7/29/15.
//  Copyright (c) 2015 Huang Yu. All rights reserved.
//

import UIKit

class KeyInfo: NSObject {
    
    var mnemonic: NSString!
    var publicKey: NSString!
    var privateKey: NSString!
    
    override init() {
        self.mnemonic = ""
        self.publicKey = ""
        self.privateKey = ""
        super.init()
    }
    
    init(mnemonic: NSString, publicKey: NSString, privateKey: NSString) {
        self.mnemonic = mnemonic
        self.publicKey = publicKey
        self.privateKey = privateKey
        super.init()
    }
    
    init(mnemonic: NSString) {
        var seedHex = NYMnemonic.deterministicSeedStringFromMnemonicString(
            mnemonic as String,
            passphrase: "",
            language: "english")
        var seedHexString = seedHex as String
        var seed: NSData = BTCDataWithHexCString(seedHexString)
        var keychain: BTCKeychain = BTCKeychain(seed: seed)
        var publicKey = keychain.extendedPublicKey
        var privateKey = keychain.extendedPrivateKey
        self.mnemonic = mnemonic
        self.publicKey = publicKey
        self.privateKey = privateKey
        super.init()
    }
}
