//
//  SearchViewModel.swift
//  RxSwiftDemo
//
//  Created by Shuhei Kawaguchi on 2016/03/29.
//  Copyright © 2016年 Shuhei Kawaguchi. All rights reserved.
//

import UIKit
import RxSwift
import APIKit

class SearchViewModel: NSObject {
    var validationMessage: Observable<Bool>!
    var searchRepository: Observable<Bool>!
    
    var searchText = PublishSubject<String>()
    var repositories = PublishSubject<[Repository]>()
    let error = PublishSubject<ErrorType>()
    
    let disposeBag = DisposeBag()
    
    let minimumSize = 3
    
    init(search: Observable<String>, buttonTap: Observable<Void>) {
        super.init()
        
        validationMessage = search
            .map { [weak self] in $0.characters.count >= self?.minimumSize }
            .shareReplay(1)
        
        search
            .bindTo(searchText)
            .addDisposableTo(disposeBag)
        
        let request = buttonTap
            .withLatestFrom(searchText)
            .map { SearchRepositoriesRequest(query: $0) }
        
        
        let response = request
            .flatMap { request in
                return Session
                    .rx_response(request)
                    .doOnError { [weak self] error in
                        self?.error.onNext(error)
                    }
                    .catchError { _ in Observable.empty() }
            }
            .shareReplay(1)
        
        response
            .map { $0.repository }
            .bindTo(repositories)
            .addDisposableTo(disposeBag)
        
        repositories
            .subscribeNext { print($0) }
            .addDisposableTo(disposeBag)
    }
}
