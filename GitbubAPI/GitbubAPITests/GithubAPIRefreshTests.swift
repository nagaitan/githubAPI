//
//  GithubAPIRefreshTests.swift
//  GitbubAPITests
//
//  Created by Adi Wibowo on 25/05/20.
//  Copyright © 2020 Adi Wibowo. All rights reserved.
//

import XCTest
import Quick
import Nimble
import RxSwift
import RxTest
import RxCocoa
@testable import GitbubAPI

class GithubAPIRefreshTests: QuickSpec {
    override func spec() {
        let stubServices = StubRefreshServices()
        var bag: DisposeBag!
        var scheduler: TestScheduler!
        var viewModel: RepoViewModel!
        
        describe("RepoListViewModel") {
            beforeEach {
                scheduler = TestScheduler(initialClock: 0)
                bag = DisposeBag()
            }
            
            context("try load repostirories") {
                beforeEach {
                    let didLoad = scheduler.createColdObservable([ Recorded.next(0, ()) ]).asObservable()
                    
                    let input = RepoViewModel.Input(
                        viewLoadTrigger: didLoad,
                        refreshTrigger: Observable<Void>.empty()
                    )
                    viewModel = RepoViewModel(input: input, serviceProvider: stubServices)
                }
                
                context("succes request") {
                    beforeEach {
                        stubServices.completeRequestWithSuccess = true
                    }
                    
                    it("should return 1, based on repo number on stub") {
                        let result = scheduler.createObserver(Int.self)
                        viewModel.repositories
                            .map({$0.count})
                            .drive(result)
                            .disposed(by: bag)
            
                        scheduler.start()
                        
                        expect(result.events).to(equal([ Recorded.next(0, 4) ]))
                    }
                }
                
                context("error request") {
                    beforeEach {
                        stubServices.completeRequestWithSuccess = false
                    }
                    
                    it("should return 0, request is set to false") {
                        let result = scheduler.createObserver(Int.self)
                        viewModel.repositories
                            .map({$0.count})
                            .drive(result)
                            .disposed(by: bag)
                        
                        scheduler.start()
                        expect(result.events).to(equal([ Recorded.next(0, 2) ]))
                    }
                }
            }
        }
    }

}

