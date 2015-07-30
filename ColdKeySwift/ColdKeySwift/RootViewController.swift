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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createNewKey(sender: AnyObject) {
        activityIndicator.startAnimating()
        self.keyInfoManager.generate()
    }

    // MARK: - Navigation
    
    @IBAction func startOver(segue: UIStoryboardSegue) {
        println("start over")
    }
    
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
    }
    */
    
    // Mark: - KeyInfoManagerDelegate 
    
    func didGenerate() {
        self.performSegueWithIdentifier("showKeyViewControllerSegue", sender: self)
    }
    
    func didReset() {
        println("did reset keyinfo")
    }
    
    // MARK: - Private Helpers

}
