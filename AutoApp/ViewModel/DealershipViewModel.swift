//
//  DealershipViewModel.swift
//  CoxAutoApp
//
//  Created by Hudson Mcashan on 5/19/19.
//  Copyright © 2019 Guardian Angel. All rights reserved.
//

import Foundation
import RxSwift

class DealershipViewModel {
    private let repo = DataRepository.shared
    private let disposeBag = DisposeBag()
    
    let data: BehaviorSubject<[Dealership]> = BehaviorSubject<[Dealership]>(value: [])
    let loading: BehaviorSubject<Bool> = BehaviorSubject<Bool>(value: false)
    init() {
        let repoData = repo.dealershipDataSubject
        let loading = repo.dealershipLoadingSubject
        
        repoData.subscribe(onNext: { (dealerships) in
            self.data.onNext(dealerships)
        }).disposed(by: disposeBag)
        
        loading.subscribe(onNext: { (loading) in
            self.loading.onNext(loading)
        }).disposed(by: disposeBag)
        
    }
}
