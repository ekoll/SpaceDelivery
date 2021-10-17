//
//  ViewController.swift
//  93652c41ebc5e7170a98811219ab09e0
//
//  Created by Ekrem Duvarbasi on 17.10.2021.
//

import UIKit
import Presentation

class LoadingView: XibViewController {
    private let viewModel: AppLoadViewModel
    
    init(viewModel: AppLoadViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel.start()
    }
}
