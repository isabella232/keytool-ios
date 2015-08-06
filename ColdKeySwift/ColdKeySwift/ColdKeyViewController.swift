//
//  ColdKeyViewController.swift
//  ColdKeySwift
//
//  Created by Huang Yu on 8/3/15.
//  Copyright (c) 2015 BitGo, Inc. All rights reserved.
//

import UIKit

class ColdKeyViewController: UIViewController {
    
    var hasBackButton: Bool = true
    var hidesBackButton: Bool = true
    var hasLogo: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        if hasBackButton {
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "",
                style: UIBarButtonItemStyle.Plain,
                target: nil, action: nil)
            self.navigationItem.backBarButtonItem?.tintColor = UIColor.whiteColor()
        }
        if hidesBackButton {
            self.navigationItem.hidesBackButton = true
        }
        
        if hasLogo {
            self.navigationItem.titleView = UIImageView(image: UIImage(named: "logo"))
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
