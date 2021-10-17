//
//  SpaceView.swift
//  93652c41ebc5e7170a98811219ab09e0
//
//  Created by Ekrem Duvarbasi on 17.10.2021.
//

import Foundation
import Presentation
import UIKit

class SpaceView: XibViewController {
    // MARK: - properties
    let viewModel: SpaceViewModel
    
    // MARK: - references
    @IBOutlet weak var stockLabel: UILabel!
    @IBOutlet weak var ustLabel: UILabel!
    @IBOutlet weak var durabilityTimeLabel: UILabel!
    
    @IBOutlet weak var shipNameLabel: UILabel!
    @IBOutlet weak var healthLabel: UILabel!
    @IBOutlet weak var healthProgress: UIProgressView!
    @IBOutlet weak var remainingSecondsLabel: UILabel!
    
    @IBOutlet weak var stationLabel: UILabel!
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - init
    init(viewModel: SpaceViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(.init(nibName: "StationCell", bundle: .main), forCellReuseIdentifier: StationCell.identifier)
        updateUI()
    }
}

// MARK: - tableView dataSource
extension SpaceView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.stations.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StationCell.identifier, for: indexPath) as! StationCell
        
        let station = viewModel.stations.data[indexPath.row]
        cell.set(viewModel: station)
        
        return cell
    }
}

// MARK: - station cell delegate
extension SpaceView: StationCellDelegate {
    func stationCell(operationFor viewModel: StationViewModel) {
        
    }
    
    func stationCell(toogleFavorite viewModel: StationViewModel) {
        
    }
}

// MARK: - renderer
extension SpaceView: Renderer {
    func updateUI() {
        
    }
}
