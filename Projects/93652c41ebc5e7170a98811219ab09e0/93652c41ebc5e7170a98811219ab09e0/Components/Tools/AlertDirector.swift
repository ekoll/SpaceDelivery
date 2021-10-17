//
//  AlertDirector.swift
//  93652c41ebc5e7170a98811219ab09e0
//
//  Created by Ekrem Duvarbasi on 17.10.2021.
//

import UIKit

class AlertDirector {

    class func alert(message: String, handler: (() -> Void)? = nil) -> UIAlertController {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler:  { _ in handler?() }))

        return alert
    }

    class func question(message: String, handler: @escaping (Bool) -> Void) -> UIAlertController {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in handler(true)}))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in handler(false) }))

        return alert
    }
}
