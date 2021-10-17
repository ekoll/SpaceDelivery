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
    
    // MARK: - ib actions
    @IBAction func tapDurabilityMinus() {
        viewModel.decreaseDurability()
    }
    
    @IBAction func tapDurabilityPlus() {
        viewModel.increaseDurability()
    }
    
    @IBAction func tapSpeedMinus() {
        viewModel.decreaseSpeed()
    }
    
    @IBAction func tapSpeedPlus() {
        viewModel.increaseSpeed()
    }
    
    @IBAction func tapCapacityMinus() {
        viewModel.decreaseCapacity()
    }
    
    @IBAction func tapCapacityPlus() {
        viewModel.increaseCapacity()
    }
    
    @IBAction func tapSave() {
        guard let text = nameTextField.text else { return }
        viewModel.update(name: text)
        viewModel.startGame()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

// MARK: - renderer
extension ShipBuildView: Renderer {
    
    func updateUI() {
        pointLabel.text = viewModel.availablePointText
        
        durabilityLabel.text = viewModel.durability
        durabilityProgressView.progress = viewModel.durabilityRatio
        durabilityMinusButton.isEnabled = viewModel.canDecreaseDurability
        durabilityPlusButton.isEnabled = viewModel.canIncreaseAbility
        
        speedLabel.text = viewModel.speed
        speedProgressView.progress = viewModel.speedRatio
        speedMinusButton.isEnabled = viewModel.canDecreaseSpeed
        speedPlusButton.isEnabled = viewModel.canIncreaseAbility
        
        capacityLabel.text = viewModel.capacity
        capacityProgressView.progress = viewModel.capacityRatio
        capacityMinusButton.isEnabled = viewModel.canDecreaseCapacity
        capacityPlusButton.isEnabled = viewModel.canIncreaseAbility
    }
}
