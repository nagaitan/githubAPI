//
//  StubServices.swift
//  GitbubAPITests
//
//  Created by Adi Wibowo on 25/05/20.
//  Copyright © 2020 Adi Wibowo. All rights reserved.
//


import Foundation
import RxSwift
@testable import GitbubAPI

class StubServices: APIConnector {
    enum StubError: Error {
        case requesFailed
    }
    
    var completeRequestWithSuccess = true
    
    private func createStubRepo() -> Repository {
        let jsonData = StubJson.getData()
        let repository = try! JSONDecoder().decode(Repository.self, from: jsonData)
        return repository
    }
    
    override func getRepositories(page: Int) -> Observable<([Repository])> {
        if completeRequestWithSuccess {
            let repo = createStubRepo()
            return Observable.just([repo]).asObservable()
        }else{
            let repositories = [Repository]()
            return Observable.just(repositories).asObservable()
        }
    }
}

class StubRefreshServices: APIConnector {
    enum StubError: Error {
        case requesFailed
    }
    
    var completeRequestWithSuccess = true
    var refreshCall = false
    
    private func createStubRepo() -> Repository {
        let jsonData = StubJson.getData()
        let repository = try! JSONDecoder().decode(Repository.self, from: jsonData)
        return repository
    }
    
    override func getRepositories(page: Int) -> Observable<([Repository])> {
        let completeWithSuccess = refreshCall ? completeRequestWithSuccess : true
        let returnNumber = refreshCall ? 4 : 2
        refreshCall = true
        
        if completeWithSuccess {
            let repo = createStubRepo()
            
            var repositories = [Repository]()
            for _ in 0..<(returnNumber) {
                repositories.append(repo)
            }
            
            return Observable.just(repositories).asObservable()
        }else{
            let repositories = [Repository]()
            return Observable.just(repositories).asObservable()
        }
    }
}

