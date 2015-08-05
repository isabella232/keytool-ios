//
//  SuccessViewController.swift
//  ColdKeySwift
//
//  Created by Huang Yu on 7/29/15.
//  Copyright (c) 2015 BitGo, Inc. All rights reserved.
//

import UIKit

class SuccessViewController: ColdKeyViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier != nil && segue.identifier == "showQRCodeViewControllerSegue" {
            if sender != nil {
                if let destVC = segue.destinationViewController as? QRCodeViewController {
                    println(destVC)
                    destVC.keyType = sender!.tag
                }
            }
        }
    }
}
