//
//  RepoViewModel.swift
//  GitbubAPI
//
//  Created by Adi Wibowo on 25/05/20.
//  Copyright © 2020 Adi Wibowo. All rights reserved.
//


import Foundation
import RxSwift
import RxCocoa

struct RepoViewModel {
    struct Input {
        let viewLoadTrigger: Observable<Void>
        let refreshTrigger: Observable<Void>
    }
    
    let repositories: Driver<[Repository]>
    let loadingList: Driver<Bool>
    let disposeBag = DisposeBag()
}

extension RepoViewModel {
    init(input: Input, serviceProvider: APIConnector = APIConnector()) {
        let currentPage = BehaviorRelay<Int>(value: 1)
        let canLoadMore = BehaviorSubject<Bool>(value: false)
        let repositoryList = BehaviorRelay<[Repository]>(value: [])
        
        func loadPage(page: Int) -> Observable<([Repository])> {
            return serviceProvider.getRepositories(page: page)
                .do(onNext : { response in
                    print("Isi Resp \(response)")
                },
                onError: { _ in
                    canLoadMore.onNext(false)
                })
                .map({ $0 })
        }
        
        let reloadTrigger = Observable.merge(input.viewLoadTrigger, input.refreshTrigger)
        
        let reloadCall = reloadTrigger
            .do(onNext: {
                currentPage.accept(1)
                canLoadMore.onNext(false)
            })
            .flatMapLatest({
                loadPage(page: currentPage.value)
                    .catchErrorJustReturn([])
            })
            .share(replay: 1, scope: .whileConnected)
        
        self.loadingList = Observable.merge(
                reloadTrigger.map({ true }),
                reloadCall.map({ _ in false })
            )
            .asDriver(onErrorJustReturn: false)
        
        self.repositories = Observable.merge(reloadCall)
            .do(onNext: { repositoryList.accept($0) })
            .asDriver(onErrorJustReturn: [])
    }
}

