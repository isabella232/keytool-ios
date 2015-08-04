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
        activityIndicator.stopAnimating()
        // Do any additional setup after loading the view.
//        self.navigationItem.titleView = UIImageView(image: UIImage(named: "logo"))
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
