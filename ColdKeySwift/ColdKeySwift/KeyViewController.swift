//
//  KeyViewController.swift
//  ColdKey
//
//  Created by Huang Yu on 7/29/15.
//  Copyright (c) 2015 Huang Yu. All rights reserved.
//

import UIKit

class KeyViewController: UIViewController {
    
    @IBOutlet var mnemonicView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var keyInfoManager = KeyInfoManager.sharedManager
        mnemonicView.text = keyInfoManager.keyInfo.mnemonic as String
        self.navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view.
    }

    @IBAction func acceptNewKey(sender: AnyObject) {
        self.performSegueWithIdentifier("showConfirmViewControllerSegue", sender: self)
    }
}
