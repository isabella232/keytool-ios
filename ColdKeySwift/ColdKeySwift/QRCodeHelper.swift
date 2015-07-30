//
//  QRCodeHelper.swift
//  ColdKey
//
//  Created by Huang Yu on 7/29/15.
//  Copyright (c) 2015 Huang Yu. All rights reserved.
//

import UIKit

class QRCodeHelper: NSObject {

    class func QRCodeForString(qrString: NSString) -> CIImage {
        var stringData = qrString.dataUsingEncoding(NSUTF8StringEncoding)
        var qrFilter = CIFilter(name: "CIQRCodeGenerator")
        qrFilter.setValue(stringData, forKey: "inputMessage")
        qrFilter.setValue("M", forKey: "inputCorrectionLevel")
        
        return qrFilter.outputImage
    }
    
    class func NonInterpolatedUIImageFromCIImage(image: CIImage, scale: CGFloat) -> UIImage {
        var cgImage = CIContext(options: nil).createCGImage(image, fromRect: image.extent())
        
        var size = CGSizeMake(
            image.extent().size.width * scale,
            image.extent().size.width * scale)
        
        UIGraphicsBeginImageContext(size)
        var context = UIGraphicsGetCurrentContext()
        CGContextSetInterpolationQuality(context,
            kCGInterpolationNone)
        CGContextDrawImage(context,
            CGContextGetClipBoundingBox(context), cgImage)
        var scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // core foundation objects are automatically managed
        //        CGImageRelease(cgImage)
        
        var flippedImage = UIImage(
            CGImage: scaledImage.CGImage,
            scale: scaledImage.scale,
            orientation: UIImageOrientation.DownMirrored)
        
        if let result = flippedImage {
            return result
        } else {
            return UIImage()
        }
        return flippedImage!
    }
}
