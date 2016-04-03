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

class SearchViewModel {
    var validation: Observable<Bool>
    var request: Observable<SearchRepositoriesRequest>
    var response: Observable<SearchRepositoriesRequest.Response>
    
    var searchText = Variable<String>("")
    var repositories = Variable<[Repository]>([])
    
    let disposeBag = DisposeBag()
    
    
    init(search: Observable<String>, buttonTap: Observable<Void>, keyboardReturn: Observable<Void>) {
        let minimumSize = 3
        validation = search
            .map { $0.characters.count >= minimumSize }
            .shareReplay(1)
        
        request = Observable
            .of(buttonTap, keyboardReturn)
            .merge()
            .withLatestFrom(searchText.asObservable())
            .map { SearchRepositoriesRequest(query: $0) }
            .shareReplay(1)
        
        response = request
            .flatMap { request in
                return Session
                    .rx_response(request)
                    .doOnError { PublishSubject<ErrorType>().onNext($0) }
                    .catchError { _ in Observable.empty() }
            }
            .shareReplay(1)
        
        response
            .map { $0.repository }
            .bindTo(repositories)
            .addDisposableTo(disposeBag)
        
        repositories
            .asObservable()
            .subscribeNext { print($0) }
            .addDisposableTo(disposeBag)
    }
}
