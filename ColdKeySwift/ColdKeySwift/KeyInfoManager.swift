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
    private(set) var publicKeyQRCode: UIImage?
    private(set) var privateKeyQRCode: UIImage?
    
    var signingKey: NSString?
    
    var delegate: KeyInfoManagerDelegate?
    
    static let sharedManager = KeyInfoManager()
    
    func generate() {
        
        // generate the new key
        dispatch_async(dispatch_get_main_queue(), {
            var mnemonic = NYMnemonic.generateMnemonicString(128 as NSNumber, language: "english")
            self.keyInfo = KeyInfo(mnemonic: mnemonic)

            // generate public key qr code
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                var cgImage = QRCodeHelper.QRCodeForString(self.keyInfo.publicKey)
                var uiImage = QRCodeHelper.NonInterpolatedUIImageFromCIImage(cgImage, scale: 3.0)
                self.publicKeyQRCode = uiImage
                
                // generate private key qr code
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    var cgImage = QRCodeHelper.QRCodeForString(self.keyInfo.privateKey)
                    var uiImage = QRCodeHelper.NonInterpolatedUIImageFromCIImage(cgImage, scale: 3.0)
                    self.privateKeyQRCode = uiImage
                    
                    if let delegate = self.delegate {
                        delegate.didGenerate()
                    }
                })

            })
        })
        
    }
    
    func reset() {
        self.keyInfo = KeyInfo(mnemonic: "", publicKey: "", privateKey: "")
        if let delegate = self.delegate {
            delegate.didReset()
        }
    }
}
