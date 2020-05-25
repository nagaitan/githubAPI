//
//  RepoListVC.swift
//  GitbubAPI
//
//  Created by Adi Wibowo on 25/05/20.
//  Copyright © 2020 Adi Wibowo. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RepoListVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private let refreshControl = UIRefreshControl()
        
        let cellReuseId = "RepoCell"
        let disposeBag = DisposeBag()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            self.setupView()
            self.bindVM()
        }
        
        func setupView() {
            self.tableView.register(UINib(nibName: cellReuseId, bundle: nil), forCellReuseIdentifier: cellReuseId)
            self.tableView.refreshControl = self.refreshControl
            tableView
            .rx.setDelegate(self)
            .disposed(by: disposeBag)
        }
        
        func bindVM() {
            let didLoadObservable = BehaviorSubject<Void>(value: ())
            
            let refreshObservable = refreshControl.rx
                .controlEvent(.valueChanged)
                .asObservable()
            
            let inputs = RepoViewModel.Input(
                viewLoadTrigger: didLoadObservable,
                refreshTrigger: refreshObservable
            )
            
            
            let viewModel = RepoViewModel(input: inputs)
            viewModel.loadingList
                .drive(onNext: { [weak self] loading in
                    let refreshControl = self?.tableView.refreshControl
                    loading ? refreshControl?.beginRefreshing() : refreshControl?.endRefreshing()
                })
                .disposed(by: disposeBag)
            
            viewModel.repositories
                .drive(tableView.rx
                    .items(cellIdentifier: cellReuseId, cellType: RepoCell.self)) { _ , repo, cell in
                        print("")
                        cell.bind(repo: repo)
                    }
                    .disposed(by: disposeBag)
            
            
            viewModel.loadingList
                .drive(refreshControl.rx.isRefreshing)
                .disposed(by: disposeBag)
        }
        
    }


extension RepoListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
