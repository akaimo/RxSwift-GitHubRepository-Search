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
//    let requestTrigger = PublishSubject<Void>()
    let error = PublishSubject<ErrorType>()
    
    var validationMessage: Observable<Bool>!
    var searchRepository: Observable<Bool>!
    
    var repositories = Variable<[Repository]>([])
    
    let disposeBag = DisposeBag()
    
    let minimumSize = 3
    
    init(search: Observable<String>, buttonTap: Observable<Void>) {
        super.init()
        
        validationMessage = search
            .map { [weak self] in $0.characters.count >= self?.minimumSize }
            .shareReplay(1)
        
//        let request = requestTrigger
//            .withLatestFrom(buttonTap)
//            .map { _ in SearchRepositoriesRequest(query: "Swift") }
        let request = buttonTap
            .map { SearchRepositoriesRequest(query: "Swift") }
        
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
            .map { response in
                print(response)
                return response.repository
            }
            .bindTo(repositories)
            .addDisposableTo(disposeBag)
    }
}
