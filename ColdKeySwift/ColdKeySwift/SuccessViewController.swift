//
//  SuccessViewController.swift
//  ColdKeySwift
//
//  Created by Huang Yu on 7/29/15.
//  Copyright (c) 2015 BitGo, Inc. All rights reserved.
//

import UIKit

class SuccessViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view.
    }

    @IBAction func showKey(sender: AnyObject) {
        self.performSegueWithIdentifier(
            "showQRCodeViewControllerSegue",
            sender: sender)
    }
    
    @IBAction func backFromQRCode(segue: UIStoryboardSegue) {
        println("back from qrcode view")
    }
    
    @IBAction func backFromScan(segue: UIStoryboardSegue) {
        println("back from scanning")
    }
}
