//
//  XibViewController.swift
//  93652c41ebc5e7170a98811219ab09e0
//
//  Created by Ekrem Duvarbasi on 17.10.2021.
//

import UIKit
import Foundation

class XibViewController: UIViewController {
    
    init(nibName: String? = nil) {
        super.init(
            nibName: nibName ?? String(describing: Self.self),
            bundle: .main
        )
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
