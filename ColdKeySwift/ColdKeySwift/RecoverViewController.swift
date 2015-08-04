//
//  RecoverViewController.swift
//  ColdKeySwift
//
//  Created by Huang Yu on 8/3/15.
//  Copyright (c) 2015 BitGo, Inc. All rights reserved.
//

import UIKit

class RecoverViewController: ColdKeyViewController, KeyInfoManagerDelegate {

    override func viewDidLoad() {
        self.hidesBackButton = false
        super.viewDidLoad()

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
    
    func didGenerate() {
        self.performSegueWithIdentifier("showRecoverQRCodeViewControllerSegue", sender: self)
    }
    
    func didReset() {
        println("did reset keyinfo")
    }
    
}
