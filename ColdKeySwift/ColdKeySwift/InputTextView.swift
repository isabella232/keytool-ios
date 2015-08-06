//
//  InputTextView.swift
//  ColdKeySwift
//
//  Created by Huang Yu on 8/4/15.
//  Copyright (c) 2015 BitGo, Inc. All rights reserved.
//

import UIKit

@IBDesignable
class InputTextView: UITextView {

    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.CGColor
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
    }
}
