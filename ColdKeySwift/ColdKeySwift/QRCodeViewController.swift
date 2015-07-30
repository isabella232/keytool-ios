//
//  QRCodeViewController.swift
//  ColdKeySwift
//
//  Created by Huang Yu on 7/29/15.
//  Copyright (c) 2015 BitGo, Inc. All rights reserved.
//

import UIKit

class QRCodeViewController: UIViewController {
    
    var keyType: Int = 0

    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var qrCodeView: UIImageView!
    
    @IBOutlet var keyTextView: UITextView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var kiManager = KeyInfoManager.sharedManager
        var keyString: NSString
        var qrCode: UIImage?
        if self.keyType == 1 {
            self.titleLabel.text = "Private Key"
            keyString = kiManager.keyInfo.privateKey
            qrCode = kiManager.privateKeyQRCode
        } else {
            self.titleLabel.text = "Public Key"
            keyString = kiManager.keyInfo.publicKey
            qrCode = kiManager.publicKeyQRCode
        }
        self.keyTextView.text = keyString as String
        if let qr = qrCode {
            self.qrCodeView.image = qr
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
}
