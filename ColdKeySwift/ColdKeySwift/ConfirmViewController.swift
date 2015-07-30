//
//  ConfirmViewController.swift
//  ColdKey
//
//  Created by Huang Yu on 7/29/15.
//  Copyright (c) 2015 Huang Yu. All rights reserved.
//

import UIKit

class ConfirmViewController: UIViewController {
    
    @IBOutlet var mnemonicView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var kiManager = KeyInfoManager.sharedManager
        self.mnemonicView.text = kiManager.keyInfo.mnemonic as String
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func confirmKey(sender: AnyObject) {
        self.performSegueWithIdentifier("showSuccessViewControllerSegue", sender: self)
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
