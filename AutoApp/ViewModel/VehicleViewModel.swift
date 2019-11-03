//
//  VehicleViewModel.swift
//  CoxAutoApp
//
//  Created by Hudson Mcashan on 5/19/19.
//  Copyright © 2019 Guardian Angel. All rights reserved.
//

import Foundation
import RxSwift

class VehicleViewModel {
    private let repo = DataRepository.shared
    private let disposeBag = DisposeBag()
    
    let data: BehaviorSubject<[Vehicle]> = BehaviorSubject<[Vehicle]>(value: [])
    let loading: BehaviorSubject<Bool> = BehaviorSubject<Bool>(value: false)
    
    init() {
        let repoData = repo.vehicleDataSubject
        let loading = repo.vehicleLoadingSubject
        
        repoData.subscribe(onNext: { (vehicles) in
            self.data.onNext(vehicles)
        }).disposed(by: disposeBag)
        
        loading.subscribe(onNext: { (loading) in
            self.loading.onNext(loading)
        }).disposed(by: disposeBag)
        
    }
}
