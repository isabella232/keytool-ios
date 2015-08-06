//
//  KeyViewController.swift
//  ColdKey
//
//  Created by Huang Yu on 7/29/15.
//  Copyright (c) 2015 Huang Yu. All rights reserved.
//

import UIKit

class KeyViewController: ColdKeyViewController, UITextViewDelegate {
    
    @IBOutlet var mnemonicView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mnemonicView.text = KeyInfoManager.sharedManager.keyInfo.mnemonicString()
        // Do any additional setup after loading the view.
        mnemonicView.layer.borderColor = UIColor(red: 9.0, green: 161.0, blue: 217.0, alpha: 1.0).CGColor
        mnemonicView.layer.borderWidth = 1.0
    }

    @IBAction func acceptNewKey(sender: AnyObject) {
        self.performSegueWithIdentifier("showConfirmViewControllerSegue", sender: self)
    }
}
