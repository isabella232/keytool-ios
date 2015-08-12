//
//  AlertManager.swift
//  ColdKeySwift
//
//  Created by Huang Yu on 8/6/15.
//  Copyright (c) 2015 BitGo, Inc. All rights reserved.
//

import UIKit

public enum AlertTitle: String {
    case Warning = "Warning"
    case StartOver = "Start Over"
    case Accept = "Accept"
    case IncorrectSeed = "Incorrect Seed"
    case TooShort = "Too Short"
    case TooLong = "Too Long"
    case PairingSucceeded = "Pairing Succeeded"
    case PairingFailed = "Pairing Failed"
}

public enum AlertMessage: String {
    case Screenshot = "Taking a screenhost compromises the security of this key since other apps may access photos on your device."
    case StartOver = "Are you sure you want to discard this seed phrase and start over?"
    case Accept = "Have you copied the seed phrase? The next screen will ask you to re-enter it."
    case IncorrectSeed = "The seed you entered does not match the seed we provided you. Please recheck what you've written down and try again"
    case TooShort = "The seed phrase you entered is too short. Please try again."
    case TooLong = "The seed phrase you entered is too long. Please try again."
    case PairingSucceeded = "These keys have been successfully paired with your BitGo wallet"
    case PairingFailed = "Something went wrong. Please try again."
}

public enum CancelButtonTitle: String {
    case Cancel = "Cancel"
    case No = "No"
}

public enum OtherButtonTitle: String {
    case OK = "OK"
    case StartOver = "Start Over"
    case Yes = "Yes"
}


extension UIAlertView {
    convenience init(
        title: AlertTitle,
        message: AlertMessage,
        cancelButtonTitle: CancelButtonTitle?,
        otherButtonTitle: OtherButtonTitle,
        delegate: UIAlertViewDelegate?)
    {
        self.init(
            title: title.rawValue,
            message: message.rawValue,
            delegate: delegate,
            cancelButtonTitle: cancelButtonTitle?.rawValue,
            otherButtonTitles: otherButtonTitle.rawValue
        )
    }
}

public enum AlertType {
    case
    TakeScreenshot,
    PairingSucceeded,
    PairingFailed,
    TooShort,
    TooLong,
    IncorrectSeed,
    Accept,
    StartOver
}

extension UIAlertView {
    convenience init(type: AlertType, delegate: UIAlertViewDelegate?) {
        var alertView: UIAlertView
        switch type {
        case .TakeScreenshot:
            self.init(
                title: .Warning,
                message: .Screenshot,
                cancelButtonTitle: nil,
                otherButtonTitle: .StartOver,
                delegate: delegate
            )
        case .PairingSucceeded:
            self.init(
                title: .PairingSucceeded,
                message: .PairingSucceeded,
                cancelButtonTitle: nil,
                otherButtonTitle: .OK,
                delegate: delegate
            )
        case .PairingFailed:
            self.init(
                title: .PairingFailed,
                message: .PairingFailed,
                cancelButtonTitle: nil,
                otherButtonTitle: .OK,
                delegate: delegate
            )
        case .TooLong:
            self.init(
                title: .TooLong,
                message: .TooLong,
                cancelButtonTitle: nil,
                otherButtonTitle: .OK,
                delegate: delegate
            )
        case .TooShort:
            self.init(
                title: .TooShort,
                message: .TooShort,
                cancelButtonTitle: nil,
                otherButtonTitle: .OK,
                delegate: delegate
            )
        case .IncorrectSeed:
            self.init(
                title: .IncorrectSeed,
                message: .IncorrectSeed,
                cancelButtonTitle: nil,
                otherButtonTitle: .OK,
                delegate: delegate
            )
        case .Accept:
            self.init(
                title: .Accept,
                message: .Accept,
                cancelButtonTitle: .No,
                otherButtonTitle: .Yes,
                delegate: delegate
            )
        case .StartOver:
            self.init(
                title: .StartOver,
                message: .StartOver,
                cancelButtonTitle: .Cancel,
                otherButtonTitle: .StartOver,
                delegate: delegate
            )
        default:
            self.init(
                title: .Warning,
                message: .PairingFailed,
                cancelButtonTitle: nil,
                otherButtonTitle: .OK,
                delegate: nil
            )
        }
    }
}
