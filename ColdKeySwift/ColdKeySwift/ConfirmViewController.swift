//
//  ConfirmViewController.swift
//  ColdKey
//
//  Created by Huang Yu on 7/29/15.
//  Copyright (c) 2015 Huang Yu. All rights reserved.
//

import UIKit

class ConfirmViewController: ColdKeyViewController, UITextViewDelegate, UIAlertViewDelegate {
    
    @IBOutlet var mnemonicView: BitGoTextView!
    @IBOutlet var bottomLayoutConstraint: NSLayoutConstraint!
    
    var words: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mnemonicView.delegate = self
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
    
    @IBAction func pressStartOver(sender: AnyObject) {
        self.mnemonicView.resignFirstResponder()
        UIAlertView(type: .StartOver, delegate: self).show()
    }
    
    @IBAction func confirmKey(sender: AnyObject) {
        
        ///////should only exists in debug version
        
        if self.mnemonicView.text == "!" {
            self.performSegueWithIdentifier("showSuccessViewControllerSegue", sender: self)
            return
        }
        
        ///////
        
        if self.mnemonicView.text != KeyInfoManager.sharedManager.keyInfo.mnemonicString() {
            self.mnemonicView.borderColor = UIColor.redColor()
            UIAlertView(type: .IncorrectSeed, delegate: self).show()
            return
        }
        self.performSegueWithIdentifier("showSuccessViewControllerSegue", sender: self)
    }
    
    @IBOutlet var confirmButton: UIButton!
    
    // MARK: - TextViewDelegate
    
    func textViewDidChange(textView: UITextView) {
        var mnString = KeyInfoManager.sharedManager.keyInfo.mnemonicString()
        if mnString.hasPrefix(textView.text) {
            self.mnemonicView.borderColor = UIColor(red: 9.0/256.0, green: 161.0/256.0, blue: 217.0/256.0, alpha: 1.0)
        } else {
            textView.layer.borderColor = UIColor.redColor().CGColor
        }
    }
    
    func textView(
        textView: UITextView,
        shouldChangeTextInRange range: NSRange,
        replacementText text: String) -> Bool
    {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    // MARK: - UIAlertViewDelegate
    
    override func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if alertView.title == AlertTitle.StartOver.rawValue {
            if buttonIndex == 1 {
                
                // a hack to prevent keyboard glitch, which happens after this VC is dismissed
                var delay = dispatch_time(DISPATCH_TIME_NOW, Int64(200 * Double(NSEC_PER_MSEC)))
                dispatch_after(delay, dispatch_get_main_queue(), { () -> Void in
                    self.performSegueWithIdentifier(
                        "backToRootViewControllerFromConfirmSegue",
                        sender: self
                    )
                })
            }
        } else if alertView.title == AlertTitle.IncorrectSeed.rawValue {
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
        bottomLayoutConstraint.constant = CGRectGetMaxY(view.bounds) - CGRectGetMinY(convertedKeyboardEndFrame)
        
        UIView.animateWithDuration(animationDuration, delay: 0.0, options: .BeginFromCurrentState | animationCurve, animations: {
            self.view.layoutIfNeeded()
            }, completion: nil)
    }
}

