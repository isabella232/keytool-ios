//
//  RootViewController.swift
//  ColdKey
//
//  Created by Huang Yu on 7/29/15.
//  Copyright (c) 2015 Huang Yu. All rights reserved.
//

import UIKit

class RootViewController: UIViewController, KeyInfoManagerDelegate {
    
    var keyInfoManager: KeyInfoManager = KeyInfoManager.sharedManager

    override func viewDidLoad() {
        super.viewDidLoad()
        self.keyInfoManager.delegate = self
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
        activityIndicator.stopAnimating()
        self.navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view.
    }

    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    @IBAction func createNewKey(sender: AnyObject) {
        activityIndicator.startAnimating()
        self.keyInfoManager.generate()
    }

    // MARK: - Navigation
    
    @IBAction func startOver(segue: UIStoryboardSegue) {
        println("start over")
        self.keyInfoManager.reset()
    }
    
    // Mark: - KeyInfoManagerDelegate 
    
    func didGenerate() {
        self.performSegueWithIdentifier("showKeyViewControllerSegue", sender: self)
    }
    
    func didReset() {
        println("did reset keyinfo")
    }
}
