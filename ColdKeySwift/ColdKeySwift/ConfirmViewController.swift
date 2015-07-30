//
//  ConfirmViewController.swift
//  ColdKey
//
//  Created by Huang Yu on 7/29/15.
//  Copyright (c) 2015 Huang Yu. All rights reserved.
//

import UIKit

class ConfirmViewController: UIViewController {
    
    @IBOutlet var mnemonicView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var kiManager = KeyInfoManager.sharedManager
        self.mnemonicView.text = kiManager.keyInfo.mnemonic as String
        self.navigationItem.hidesBackButton = true
    }
    
    @IBAction func confirmKey(sender: AnyObject) {
        self.performSegueWithIdentifier("showSuccessViewControllerSegue", sender: self)
    }
}
