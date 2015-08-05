//
//  KeyInfo.swift
//  ColdKey
//
//  Created by Huang Yu on 7/29/15.
//  Copyright (c) 2015 Huang Yu. All rights reserved.
//

import UIKit

class KeyInfo: NSObject {
    
    var mnemonic: BTCMnemonic!
    var publicKey: NSString!
    var privateKey: NSString!
    
    func mnemonicString() -> String {
        var array = self.mnemonic.words as! [String]
        return " ".join(array)
    }
    
    override init() {
        self.mnemonic = BTCMnemonic()
        self.publicKey = ""
        self.privateKey = ""
        super.init()
    }
    
    init(mnemonic: BTCMnemonic!, publicKey: NSString, privateKey: NSString) {
        self.mnemonic = mnemonic
        self.publicKey = publicKey
        self.privateKey = privateKey
        super.init()
    }
    
    init(data mnData: NSData) {
        self.mnemonic = BTCMnemonic(
            entropy: mnData,
            password: "",
            wordListType: BTCMnemonicWordListType.English)
        var keychain = self.mnemonic.keychain
        var publicKey = keychain.extendedPublicKey
        var privateKey = keychain.extendedPrivateKey
        self.publicKey = publicKey
        self.privateKey = privateKey
        super.init()
    }
    
    init(words mnWords: [String]) {
        self.mnemonic = BTCMnemonic(
            words: mnWords,
            password: "",
            wordListType: BTCMnemonicWordListType.English)
        var keychain = self.mnemonic.keychain
        var publicKey = keychain.extendedPublicKey
        var privateKey = keychain.extendedPrivateKey
        self.publicKey = publicKey
        self.privateKey = privateKey
        super.init()
    }
}
