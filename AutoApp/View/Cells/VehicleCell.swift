//
//  VehicleCell.swift
//  CoxAutoApp
//
//  Created by Hudson Mcashan on 5/19/19.
//  Copyright © 2019 Guardian Angel. All rights reserved.
//

import UIKit

class VehicleCell: UITableViewCell {
    static let identifier = "VehicleCell"
    
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var makeLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var vehicleIdLabel: UILabel!
    @IBOutlet weak var dealershipIdLabel: UILabel!
    
    func configure(with vehicle: Vehicle) {
        yearLabel.text = String(vehicle.year)
        makeLabel.text = vehicle.make
        modelLabel.text = vehicle.model
        vehicleIdLabel.text = String(vehicle.vehicleId)
        dealershipIdLabel.text = String(vehicle.dealerId)
    }
}
