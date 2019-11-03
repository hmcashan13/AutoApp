//
//  DealershipCell.swift
//  CoxAutoApp
//
//  Created by Hudson Mcashan on 5/19/19.
//  Copyright © 2019 Guardian Angel. All rights reserved.
//

import UIKit

class DealershipCell: UITableViewCell {
    static let identifier = "DealershipCell"
    
    @IBOutlet weak var dealershipNameLabel: UILabel!
    @IBOutlet weak var dealershipIdLabel: UILabel!
    
    func configure(with dealership: Dealership) {
        dealershipNameLabel.text = dealership.name
        dealershipIdLabel.text = String(dealership.id)
    }
}
