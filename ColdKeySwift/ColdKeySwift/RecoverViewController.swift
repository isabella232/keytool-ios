//
//  RecoverViewController.swift
//  ColdKeySwift
//
//  Created by Huang Yu on 8/3/15.
//  Copyright (c) 2015 BitGo, Inc. All rights reserved.
//

import UIKit

class RecoverViewController: ColdKeyViewController, KeyInfoManagerDelegate, UITextViewDelegate {

    override func viewDidLoad() {
        self.hidesBackButton = false
        super.viewDidLoad()
        self.mnemonicView.delegate = self
        // Do any additional setup after loading the view.
    }

    @IBOutlet var mnemonicView: UITextView!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recoverPrivateKey(sender: AnyObject) {
        KeyInfoManager.sharedManager.delegate = self
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
                println(destVC)
                destVC.keyType = 1
            }
        }
    }
    
    // MARK: - TextViewDelegate
    
//    func textViewDidChange(textView: UITextView) {
//        var mnString = KeyInfoManager.sharedManager.keyInfo.mnemonicString()
//        if mnString.hasPrefix(textView.text) {
//            textView.layer.borderColor = UIColor(red: 9.0, green: 161.0, blue: 217.0, alpha: 1.0).CGColor
//        } else {
//            textView.layer.borderColor = UIColor.redColor().CGColor
//        }
//    }
    
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
