//
//  UIViewController+Renderer.swift
//  93652c41ebc5e7170a98811219ab09e0
//
//  Created by Ekrem Duvarbasi on 17.10.2021.
//

import Presentation
import UIKit

extension Renderer where Self: UIViewController {
    func updateUI() { }
    
    func present(error: String) {
        present(AlertDirector.alert(message: error, handler: nil), animated: true)
    }
    
    func present(alert: String) {
        present(AlertDirector.alert(message: alert, handler: nil), animated: true)
    }
    
    func ask(yesNoQuestion: String, completion: @escaping (Bool) -> Void) {
        present(AlertDirector.question(message: yesNoQuestion, handler: completion), animated: true)
    }
}
