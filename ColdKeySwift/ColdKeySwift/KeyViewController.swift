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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func acceptNewKey(sender: AnyObject) {
        self.performSegueWithIdentifier("showConfirmViewControllerSegue", sender: self)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
