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
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        mnemonicView.updateConstraints()
    }

    @IBAction func acceptNewKey(sender: AnyObject) {
        self.performSegueWithIdentifier("showConfirmViewControllerSegue", sender: self)
    }
}
