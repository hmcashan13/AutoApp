//
//  DealershipViewController.swift
//  CoxAutoApp
//
//  Created by Hudson Mcashan on 5/19/19.
//  Copyright © 2019 Guardian Angel. All rights reserved.
//

import UIKit
import RxSwift

class DealershipViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Dealerships"
        
        let viewModel = DealershipViewModel()
        bindTableView(with: viewModel)
        bindLoadingView(with: viewModel)
    }
    
    private func bindTableView(with viewModel: DealershipViewModel) {
        tableView.dataSource = nil
        tableView.delegate = nil
        viewModel.data.bind(to: tableView.rx.items(cellIdentifier: DealershipCell.identifier, cellType: DealershipCell.self)) { _,model,cell in
            cell.configure(with: model)
        }.disposed(by: disposeBag)
    }
    
    private func bindLoadingView(with viewModel: DealershipViewModel) {
        viewModel.loading.subscribe(onNext: { [weak self] (isLoading) in
            guard let strongSelf = self else { return }
            isLoading ? showLoadingView(presenter: strongSelf) : removeLoadingView(remover: strongSelf)
        }).disposed(by: disposeBag)
    }
}

func showLoadingView(presenter: UIViewController) {
    let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
    
    let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
    loadingIndicator.hidesWhenStopped = true
    loadingIndicator.style = UIActivityIndicatorView.Style.gray
    loadingIndicator.startAnimating();
    
    alert.view.addSubview(loadingIndicator)
    presenter.present(alert, animated: true, completion: nil)
}

func removeLoadingView(remover: UIViewController) {
    remover.dismiss(animated: false, completion: nil)
}
