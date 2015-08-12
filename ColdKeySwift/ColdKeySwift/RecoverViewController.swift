//
//  RecoverViewController.swift
//  ColdKeySwift
//
//  Created by Huang Yu on 8/3/15.
//  Copyright (c) 2015 BitGo, Inc. All rights reserved.
//

import UIKit
import QuartzCore

class RecoverViewController: ColdKeyViewController, KeyInfoManagerDelegate, UITextViewDelegate, UIAlertViewDelegate {

    override func viewDidLoad() {
        self.hidesBackButton = false
        super.viewDidLoad()
        self.mnemonicView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "keyboardWillShowNotification:",
            name: UIKeyboardWillShowNotification,
            object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "keyboardWillHideNotification:",
            name: UIKeyboardWillHideNotification,
            object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self,
            name: UIKeyboardWillShowNotification,
            object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self,
            name: UIKeyboardWillHideNotification,
            object: nil)
    }
    
    @IBOutlet var mnemonicView: BitGoTextView!
    @IBOutlet var bottomLayoutConstraint: NSLayoutConstraint!
    
    @IBAction func recoverPrivateKey(sender: AnyObject) {
        KeyInfoManager.sharedManager.delegate = self
        var words = KeyInfoManager.mnemonicArray(mnemonicView.text)
        if let wordArray = words {
            if wordArray.count > 12 {
                UIAlertView(type: .TooLong, delegate: self).show()
            } else if wordArray.count < 12 {
                UIAlertView(type: .TooShort, delegate: self).show()
            } else if self.isValid(wordArray) {
                KeyInfoManager.sharedManager.generate(mnemonic: mnemonicView.text)
            }
        }
        return
    }
    
    func didGenerateKeyInfo() {
        self.performSegueWithIdentifier("showRecoverQRCodeViewControllerSegue", sender: self)
    }
    
    func didResetKeyInfo() {
        println("did reset keyinfo")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier != nil && segue.identifier == "showRecoverQRCodeViewControllerSegue" {
            if let destVC = segue.destinationViewController as? QRCodeViewController {
                destVC.keyType = 1
            }
        }
    }
    
    // MARK: - TextViewDelegate
    
    func textViewDidChange(textView: UITextView) {
        var words = KeyInfoManager.mnemonicArray(textView.text)
        if words != nil {
            if self.isValid(words!) {
                self.mnemonicView.borderColor = UIColor(red: 9.0/256.0, green: 161.0/256.0, blue: 217.0/256.0, alpha: 1.0)
            } else {
                mnemonicView.borderColor = UIColor.redColor()
            }
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
    
    private func isValid(words: [String]) -> Bool {
        for word in words {
            if !contains(KeyInfoManager.wordList, word) {
                return false
            }
        }
        return true
    }
    
    // MARK: - UIAlertViewDelegate Protocol
    
    override func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if alertView.title == AlertTitle.TooLong.rawValue || alertView.title == AlertTitle.TooShort.rawValue {
            self.mnemonicView.becomeFirstResponder()
        } else {
            super.alertView(alertView, clickedButtonAtIndex: buttonIndex)
        }
    }
    
    // MARK: - Notifications
    
    func keyboardWillShowNotification(notification: NSNotification) {
        updateBottomLayoutConstraintWithNotification(notification)
    }
    
    func keyboardWillHideNotification(notification: NSNotification) {
        updateBottomLayoutConstraintWithNotification(notification)
    }
    
    
    // MARK: - Private
    
    func updateBottomLayoutConstraintWithNotification(notification: NSNotification) {
        let userInfo = notification.userInfo!
        let animationDuration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let keyboardEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        let convertedKeyboardEndFrame = view.convertRect(keyboardEndFrame, fromView: view.window)
        let rawAnimationCurve = (notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).unsignedIntValue << 16
        let animationCurve = UIViewAnimationOptions(rawValue: UInt(rawAnimationCurve))
        bottomLayoutConstraint.constant = CGRectGetMaxY(view.bounds) - CGRectGetMinY(convertedKeyboardEndFrame) + 20 // extra margin
        
        UIView.animateWithDuration(animationDuration, delay: 0.0, options: .BeginFromCurrentState | animationCurve, animations: {
            self.view.layoutIfNeeded()
            }, completion: nil)
    }
}

