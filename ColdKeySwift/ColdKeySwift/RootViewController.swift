//
//  RootViewController.swift
//  ColdKey
//
//  Created by Huang Yu on 7/29/15.
//  Copyright (c) 2015 Huang Yu. All rights reserved.
//

import UIKit

class RootViewController: ColdKeyViewController, KeyInfoManagerDelegate {
    
    var keyInfoManager: KeyInfoManager = KeyInfoManager.sharedManager

    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        activityIndicator.stopAnimating()
        self.keyInfoManager.reset()
    }

    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    @IBAction func createNewKey(sender: AnyObject) {
        self.keyInfoManager.delegate = self
        activityIndicator.startAnimating()
        self.keyInfoManager.generate()
    }

    @IBAction func recoverKey(sender: AnyObject) {
        self.performSegueWithIdentifier("showRecoverViewControllerSegue",
            sender: self)
    }
    
    // MARK: - Navigation
    
    @IBAction func startOver(segue: UIStoryboardSegue) {
        println("start over")
    }
    
    // Mark: - KeyInfoManagerDelegate 
    
    func didGenerateKeyInfo() {
        self.performSegueWithIdentifier("showKeyViewControllerSegue", sender: self)
    }
    
    func didResetKeyInfo() {
        println("did reset keyinfo")
    }
}
