//
//  ShipBuildView.swift
//  93652c41ebc5e7170a98811219ab09e0
//
//  Created by Ekrem Duvarbasi on 17.10.2021.
//

import UIKit
import Presentation

class ShipBuildView: XibViewController {
    // MARK: - properties
    let viewModel: ShipBuildViewModel
    
    // MARK: - references
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var durabilityLabel: UILabel!
    @IBOutlet weak var durabilityProgressView: UIProgressView!
    @IBOutlet weak var durabilityMinusButton: UIButton!
    @IBOutlet weak var durabilityPlusButton: UIButton!
    
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var speedProgressView: UIProgressView!
    @IBOutlet weak var speedMinusButton: UIButton!
    @IBOutlet weak var speedPlusButton: UIButton!
    
    @IBOutlet weak var capacityLabel: UILabel!
    @IBOutlet weak var capacityProgressView: UIProgressView!
    @IBOutlet weak var capacityMinusButton: UIButton!
    @IBOutlet weak var capacityPlusButton: UIButton!
    
    @IBOutlet weak var craftButton: UIButton!
    
    // MARK: - init
    init(viewModel: ShipBuildViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
}
