//
//  VehicleViewController.swift
//  CoxAutoApp
//
//  Created by Hudson Mcashan on 5/19/19.
//  Copyright © 2019 Guardian Angel. All rights reserved.
//

import UIKit
import RxSwift

class VehicleViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Vehicles"
        
        let viewModel = VehicleViewModel()
        bindTableView(with: viewModel)
        bindLoadingView(with: viewModel)
    }

    private func bindTableView(with viewModel: VehicleViewModel) {
        tableView.dataSource = nil
        tableView.delegate = nil
        viewModel.data.bind(to: tableView.rx.items(cellIdentifier: VehicleCell.identifier, cellType: VehicleCell.self)) { _,model,cell in
            cell.configure(with: model)
        }.disposed(by: disposeBag)
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    private func bindLoadingView(with viewModel: VehicleViewModel) {
        viewModel.loading.subscribe(onNext: { [weak self] (isLoading) in
            guard let strongSelf = self else { return }
            isLoading ? showLoadingView(presenter: strongSelf) : removeLoadingView(remover: strongSelf)
        }).disposed(by: disposeBag)
    }
}

extension VehicleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}
