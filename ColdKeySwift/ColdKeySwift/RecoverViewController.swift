//
//  RecoverViewController.swift
//  ColdKeySwift
//
//  Created by Huang Yu on 8/3/15.
//  Copyright (c) 2015 BitGo, Inc. All rights reserved.
//

import UIKit
import QuartzCore

class RecoverViewController: ColdKeyViewController, KeyInfoManagerDelegate, UITextViewDelegate {

    override func viewDidLoad() {
        self.hidesBackButton = false
        super.viewDidLoad()
        self.mnemonicView.delegate = self
        self.mnemonicView.layer.borderWidth = 1.0
        self.mnemonicView.layer.borderColor = UIColor(red: 9.0/256.0, green: 161.0/256.0, blue: 217.0/256.0, alpha: 1.0).CGColor
        // Do any additional setup after loading the view.
    }

    @IBOutlet var mnemonicView: UITextView!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recoverPrivateKey(sender: AnyObject) {
        KeyInfoManager.sharedManager.delegate = self
        var words = KeyInfoManager.mnemonicArray(mnemonicView.text)
        if words == nil || words?.count != 12 {
            return
        } else if !self.isValid(words!) {
            return
        }
        KeyInfoManager.sharedManager.generate(mnemonic: mnemonicView.text)
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
                self.mnemonicView.layer.borderColor = UIColor(red: 9.0/256.0, green: 161.0/256.0, blue: 217.0/256.0, alpha: 1.0).CGColor
            } else {
                mnemonicView.layer.borderColor = UIColor.redColor().CGColor
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
}

