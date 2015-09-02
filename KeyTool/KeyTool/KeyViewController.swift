//
//  KeyViewController.swift
//  KeyTool
//
//  Created by Huang Yu on 7/29/15.
//  Copyright (c) 2015 BitGo, Inc. All rights reserved.
//

import UIKit

class KeyViewController: KeyToolViewController, UITextViewDelegate, UIAlertViewDelegate {
    
    @IBOutlet var mnemonicView: BitGoTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mnemonicView.text = KeyInfoManager.sharedManager.keyInfo.mnemonicString()
        // Do any additional setup after loading the view.
    }

    @IBAction func acceptNewKey(sender: AnyObject) {
        UIAlertView(type: .Accept, delegate: self).show()
    }
    
    // MARK: - UIAlertViewDelegate
    
    @IBAction func pressStartOver(sender: AnyObject) {
        UIAlertView(type: .StartOver, delegate: self).show()
    }
    
    override func alertView(
        alertView: UIAlertView,
        clickedButtonAtIndex buttonIndex: Int)
    {        
        if alertView.title == AlertTitle.StartOver.rawValue {
            if buttonIndex == 1 {
                self.performSegueWithIdentifier(
                    "backToRootViewControllerFromKeySegue",
                    sender: self
                )
            }
        } else if alertView.title == AlertTitle.Accept.rawValue {
            if buttonIndex == 1 {
                self.performSegueWithIdentifier("showConfirmViewControllerSegue", sender: self)
            }
        } else {
            super.alertView(alertView, clickedButtonAtIndex: buttonIndex)
        }
    }
}
