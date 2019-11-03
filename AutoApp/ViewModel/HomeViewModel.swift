//
//  HomeViewModel.swift
//  CoxAutoApp
//
//  Created by Hudson Mcashan on 5/19/19.
//  Copyright © 2019 Guardian Angel. All rights reserved.
//

import Foundation

class HomeViewModel {
    private let repo = DataRepository.shared
    
    func getData() {
        repo.getVehicleData { [weak self] dealerId in
            self?.repo.getDealershipData(with: dealerId)
        }
    }
}
