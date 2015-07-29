//
//  KeyInfo.swift
//  ColdKey
//
//  Created by Huang Yu on 7/29/15.
//  Copyright (c) 2015 Huang Yu. All rights reserved.
//

import UIKit

class KeyInfo: NSObject {
    let mnemonic: NSString!
    let publicKey: NSString!
    let privateKey: NSString!
    
    init(mnemonic: NSString, publicKey: NSString, privateKey: NSString) {
        self.mnemonic = mnemonic
        self.publicKey = publicKey
        self.privateKey = privateKey
        super.init()
    }
}


//CKKeyInfo *KeyInfofromMnemonic(NSString *mnemonic)
//{
//    NSString *seedHEX = [NYMnemonic deterministicSeedStringFromMnemonicString:mnemonic
//        passphrase:@""
//    language:@"english"];
//    NSData* seed = BTCDataWithHexCString([seedHEX UTF8String]);
//    
//    BTCKeychain *keychain = [[BTCKeychain alloc] initWithSeed:seed];
//    NSString *publicKey = BTCBase58CheckStringWithData([keychain extendedPublicKeyData]);
//    NSString *privateKey = BTCBase58CheckStringWithData([keychain extendedPrivateKeyData]);
//    
//    CKKeyInfo *keyInfo = [[CKKeyInfo alloc] initWithMnemonic:mnemonic publicKey:publicKey privateKey:privateKey];
//    return keyInfo;
//}