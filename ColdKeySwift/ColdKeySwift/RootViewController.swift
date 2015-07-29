//
//  RootViewController.swift
//  ColdKey
//
//  Created by Huang Yu on 7/29/15.
//  Copyright (c) 2015 Huang Yu. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
        activityIndicator.stopAnimating()
        // Do any additional setup after loading the view.
    }

    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createNewKey(sender: AnyObject) {
        activityIndicator.startAnimating()
        self.performSegueWithIdentifier("showKeyViewControllerSegue", sender: self)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    private func generateKeys() -> KeyInfo {
//        var mnemonic = NYMnemonic.generateMnemonicString(128, language: "english")
        return KeyInfo(mnemonic: "a", publicKey: "b", privateKey: "c")
    }
    
//    private func generateKeys() ->
//    
//    - (CKKeyInfo *)_generateKeys
//    {
//    // Generating a mnemonic
//    NSString *mnemonic = [NYMnemonic generateMnemonicString:@128 language:@"english"];
//    CKKeyInfo *keyInfo = KeyInfofromMnemonic(mnemonic);
//    return keyInfo;
//    }
}
