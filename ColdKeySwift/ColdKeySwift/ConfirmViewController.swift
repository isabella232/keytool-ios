//
//  ConfirmViewController.swift
//  ColdKey
//
//  Created by Huang Yu on 7/29/15.
//  Copyright (c) 2015 Huang Yu. All rights reserved.
//

import UIKit

class ConfirmViewController: ColdKeyViewController, UITextViewDelegate {
    
    @IBOutlet var mnemonicView: UITextView!
    
    var words: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mnemonicView.delegate = self
        self.mnemonicView.layer.borderWidth = 1.0
        self.mnemonicView.layer.borderColor = UIColor(red: 9.0/256.0, green: 161.0/256.0, blue: 217.0/256.0, alpha: 1.0).CGColor
    }
    
    @IBAction func confirmKey(sender: AnyObject) {
        if self.mnemonicView.text != KeyInfoManager.sharedManager.keyInfo.mnemonicString() {
            self.mnemonicView.layer.borderColor = UIColor.redColor().CGColor
            return
        }
        self.performSegueWithIdentifier("showSuccessViewControllerSegue", sender: self)
    }
    
    @IBOutlet var confirmButton: UIButton!
    
    // MARK: - TextViewDelegate
    
    func textViewDidChange(textView: UITextView) {
        var mnString = KeyInfoManager.sharedManager.keyInfo.mnemonicString()
        if mnString.hasPrefix(textView.text) {
            self.mnemonicView.layer.borderColor = UIColor(red: 9.0/256.0, green: 161.0/256.0, blue: 217.0/256.0, alpha: 1.0).CGColor
        } else {
            textView.layer.borderColor = UIColor.redColor().CGColor
        }
    }
    
    func textView(
        textView: UITextView,
        shouldChangeTextInRange range: NSRange,
        replacementText text: String) -> Bool {
            if text == "\n" {
                textView.resignFirstResponder()
                return false
            }
            return true
    }
}
