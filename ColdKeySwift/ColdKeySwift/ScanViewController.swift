//
//  ScanViewController.swift
//  ColdKeySwift
//
//  Created by Huang Yu on 7/30/15.
//  Copyright (c) 2015 BitGo, Inc. All rights reserved.
//

import UIKit
import AVFoundation

class ScanViewController: ColdKeyViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    var session: AVCaptureSession?

    @IBOutlet weak var previewView: UIView!
    @IBOutlet var noVideoCamLabel: UILabel!
    
    override func viewDidLoad() {
        self.hidesBackButton = false
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        var videoDeivces = AVCaptureDevice.devicesWithMediaType(AVMediaTypeVideo)
        
        if videoDeivces.count > 0 {
            self.noVideoCamLabel.hidden = true
            let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
            let input: AnyObject! = AVCaptureDeviceInput.deviceInputWithDevice(device, error: nil)
            let output = AVCaptureMetadataOutput()
            self.session = AVCaptureSession()
            if let session = self.session {
                session.addInput(input as! AVCaptureDeviceInput)
                session.addOutput(output)
                output.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
                output.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
                
                var preview = AVCaptureVideoPreviewLayer(session: session)
                preview.frame = self.previewView.bounds
                preview.videoGravity = AVLayerVideoGravityResizeAspectFill
                
                
                preview.connection.videoOrientation = AVCaptureVideoOrientation.Portrait
                self.previewView.layer.insertSublayer(preview, atIndex: 0)
                
                session.startRunning()
            }
        } else {
            self.noVideoCamLabel.hidden = false
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        if let session = self.session {
            session.stopRunning()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        if let session = self.session {
            session.stopRunning()
        }
    }
    
    // MARK: - AVCaptureMetadataOutputObjectsDelegate
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        for current in metadataObjects {
            if let validObject = current as? AVMetadataMachineReadableCodeObject {
                var scannedString = validObject.stringValue
                self.session?.stopRunning()
                KeyInfoManager.sharedManager.signingKey = scannedString
                KeyInfoManager.sharedManager.postRequest()
            }
        }
    }
}
