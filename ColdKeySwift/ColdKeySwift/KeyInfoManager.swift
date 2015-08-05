//
//  KeyInfoManager.swift
//  ColdKeySwift
//
//  Created by Huang Yu on 7/29/15.
//  Copyright (c) 2015 BitGo, Inc. All rights reserved.
//

import UIKit
import Alamofire

protocol KeyInfoManagerDelegate {
    func didGenerateKeyInfo()
    func didResetKeyInfo()
}

class KeyInfoManager: NSObject {
    private(set) var keyInfo: KeyInfo = KeyInfo()
    private(set) var publicKeyQRCode: UIImage?
    private(set) var privateKeyQRCode: UIImage?
    
    var signingKey: NSString?
    
    var delegate: KeyInfoManagerDelegate?
    
    static let sharedManager = KeyInfoManager()
    
    func generate(mnemonic providedMnemonic: NSString? = nil) {
        
        var width = UIScreen.mainScreen().bounds.width
        var scale = UIScreen.mainScreen().scale
        var size = CGSizeMake(width, width)
        
        // generate the new key
        dispatch_async(dispatch_get_main_queue(), {
            if let words = KeyInfoManager.mnemonicArray(providedMnemonic as String?) {
                self.keyInfo = KeyInfo(words: words)
            } else {
                var mnemonic = self.generateMnemonic(128)
                self.keyInfo = KeyInfo(data: mnemonic)
            }

            // generate public key qr code
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                var uiImage = BTCQRCode.imageForString(self.keyInfo.publicKey as String, size: size, scale: scale)
                self.publicKeyQRCode = uiImage
                
                // generate private key qr code
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    var uiImage = BTCQRCode.imageForString(self.keyInfo.privateKey as String, size: size, scale: scale)
                    self.privateKeyQRCode = uiImage
                    
                    if let delegate = self.delegate {
                        delegate.didGenerateKeyInfo()
                    }
                })
            })
        })
    }
    
    func reset() {
        self.keyInfo.mnemonic.clear()
        self.keyInfo = KeyInfo(mnemonic: BTCMnemonic(), publicKey: "", privateKey: "")
        self.publicKeyQRCode = nil
        self.privateKeyQRCode = nil
        self.signingKey = nil
        
        if let delegate = self.delegate {
            delegate.didResetKeyInfo()
        }
    }
    
    func postRequest() {
        if self.signingKey == nil {
            return
        }
        var parameters = [
            "id": self.signingKey,
            "xpub": self.keyInfo.publicKey
        ]
        var headers = [
            "Content-Type": "application/json; charset=utf-8"
        ]
        
        Alamofire.request(.POST, "http://192.168.0.101:3000/api/v1/coldkey",
            parameters: parameters,
            encoding: .JSON,
            headers: headers)
            .responseJSON { _, _, JSON, _ in
                println(JSON)
        }
    }
    
    func generateMnemonic(strength: Int, language: String = "english") -> NSData {
        if strength % 32 != 0 {
            NSException(
                name: "Strength must be divisible by 32",
                reason: "Strength was: \(strength)",
                userInfo: nil)
        }
        
        var bytes = UnsafeMutablePointer<UInt8>.alloc(strength / 8)
        var status = SecRandomCopyBytes(kSecRandomDefault, strength / 8, bytes)
        if status != -1 {
            return NSData(bytes: bytes, length: strength / 8)
        } else {
            return NSData()
        }
    }
    
    class func safeMnemonicString(string mnString: String?) -> String? {
        if mnString == nil {
            return nil
        }
        let regEx = NSRegularExpression(
            pattern: "[ ]+",
            options: NSRegularExpressionOptions.allZeros,
            error: nil)
        let removeTrailingRegEx = NSRegularExpression(
            pattern: "[ ]+$",
            options: NSRegularExpressionOptions.AnchorsMatchLines,
            error: nil)
        var noTrailingString: String?
        var cleanString: String?
        if regEx != nil && removeTrailingRegEx != nil {
            noTrailingString = removeTrailingRegEx?.stringByReplacingMatchesInString(
                mnString!,
                options: NSMatchingOptions.allZeros,
                range: NSMakeRange(0, count(mnString!)),
                withTemplate: "")
            if noTrailingString != nil {
                cleanString = regEx?.stringByReplacingMatchesInString(
                    noTrailingString!,
                    options: NSMatchingOptions.allZeros,
                    range: NSMakeRange(0, count(noTrailingString!)),
                    withTemplate: " ")
            }
            if cleanString != nil {
                return cleanString!
            }
        }
        println("cannot return safe mnemonic string!")
        return nil
    }
    
    class func mnemonicArray(string: String?) -> [String]? {
        
        if let safeString = KeyInfoManager.safeMnemonicString(string: string) {
            println(safeString)
            return safeString.componentsSeparatedByString(" ")
        }
        return nil
    }
}
