//
//  StationCell.swift
//  93652c41ebc5e7170a98811219ab09e0
//
//  Created by Ekrem Duvarbasi on 17.10.2021.
//

import UIKit
import Presentation

protocol StationCellDelegate: AnyObject {
    func stationCell(operationFor station: StationViewModel)
    func stationCell(toogleFavorite station: StationViewModel)
}

class StationCell: UITableViewCell {
    static var identifier: String { "station_cell" }
    
    weak var viewModel: StationViewModel?
    weak var delegate: StationCellDelegate?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ustCostLabel: UILabel!
    @IBOutlet weak var capacityLabel: UILabel!
    @IBOutlet weak var stockLabel: UILabel!
    @IBOutlet weak var needLabel: UILabel!
    
    @IBOutlet weak var homeDistanceView: UIView!
    @IBOutlet weak var homeDistanceLabel: UILabel!
    
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var operationButton: UIButton!
    
    func set(viewModel: StationViewModel) {
        self.viewModel = viewModel
        nameLabel.text = viewModel.name
        ustCostLabel.text = viewModel.ustCostText
        capacityLabel.text = viewModel.capacityText
        stockLabel.text = viewModel.stockText
        needLabel.text = viewModel.needText
        homeDistanceLabel.text = viewModel.distanceToHome
        homeDistanceView.isHidden = !viewModel.isFavourite
        
        favoriteButton.setImage(
            viewModel.isFavourite ? #imageLiteral(resourceName: "favorite-filled") : #imageLiteral(resourceName: "favorite"),
            for: .normal
        )
        operationButton.setTitle(viewModel.operation.description, for: .normal)
        operationButton.isEnabled = viewModel.operation != .nothing
    }
    
    @IBAction func tapOperation() {
        guard let viewModel = viewModel else { return }
        delegate?.stationCell(operationFor: viewModel)
    }
    
    @IBAction func tapFavorite() {
        guard let viewModel = viewModel else { return }
        delegate?.stationCell(toogleFavorite: viewModel)
    }
}
