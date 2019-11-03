//
//  DataRepository.swift
//  CoxAutoApp
//
//  Created by Hudson Mcashan on 5/19/19.
//  Copyright © 2019 Guardian Angel. All rights reserved.
//

import Foundation
import RxSwift

class DataRepository {
    private let dataFetcher = DataFetcher()
    private var vehicles: [Vehicle] = []
    private var dealerships: [Dealership] = []
    private var vehicleCount = 0
    
    static let shared = DataRepository()
    let vehicleDataSubject = BehaviorSubject<[Vehicle]>(value: [])
    let dealershipDataSubject = BehaviorSubject<[Dealership]>(value: [])
    let vehicleLoadingSubject = BehaviorSubject<Bool>(value: false)
    let dealershipLoadingSubject = BehaviorSubject<Bool>(value: false)
    
    
    func getVehicleData(completion: @escaping (Int) -> ()) {
        vehicleLoadingSubject.onNext(true)
        dataFetcher.fetchVehicleIds { [weak self] (vehicleIds) in
            guard let ids = vehicleIds else { return }
            self?.vehicleCount = ids.count
            for id in ids {
                self?.dataFetcher.fetchVehicles(with: id, completion: { [weak self] (vehicle, dealershipId) in
                    guard let vehicle = vehicle, let dealershipId = dealershipId else { return }
                    self?.vehicles.append(vehicle)
                    completion(dealershipId)
                    if let vehicles = self?.vehicles, vehicles.count == self?.vehicleCount {
                        self?.vehicleLoadingSubject.onNext(false)
                        self?.vehicleDataSubject.onNext(vehicles)
                    }
                })
            }
        }
    }
    
    func getDealershipData(with dealerId: Int) {
        dealershipLoadingSubject.onNext(true)
        self.dataFetcher.fetchDealership(with: dealerId, completion: { [weak self] (dealership) in
            guard let dealership = dealership else { return }
            self?.dealerships.append(dealership)
            if let dealerships = self?.dealerships, dealerships.count == self?.vehicleCount {
                self?.dealershipLoadingSubject.onNext(false)
                self?.dealershipDataSubject.onNext(dealerships)
            }
        })
    }
}

