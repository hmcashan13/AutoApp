//
//  ViewController.swift
//  CoxAutoApp
//
//  Created by Hudson Mcashan on 5/19/19.
//  Copyright © 2019 Guardian Angel. All rights reserved.
//

import UIKit
import Alamofire
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    @IBOutlet weak var fetchDataButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    private let rows = Observable.of(["Dealerships","Vehicles"])
    private let disposeBag = DisposeBag()
    private let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Home"
        // Do any additional setup after loading the view.
        bindButton()
        bindTableView()
    }
    
    private func bindButton() {
        fetchDataButton.rx.tap.bind {
            self.viewModel.getData()
        }.disposed(by: disposeBag)
    }
    
    private func bindTableView() {
        tableView.dataSource = nil
        tableView.delegate = nil
        rows
            .bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { (row,element,cell) in
                cell.textLabel?.text = element
            }
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected.subscribe(onNext: { [weak self] (index) in
            self?.tableView.deselectRow(at: index, animated: true)
            if index.row == 0 {
                if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DealershipViewController") as? DealershipViewController {
                    self?.viewModel.getData()
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            } else {
                if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "VehicleViewController") as? VehicleViewController {
                    self?.viewModel.getData()
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            }
            
        }).disposed(by: disposeBag)
    }
    

}

