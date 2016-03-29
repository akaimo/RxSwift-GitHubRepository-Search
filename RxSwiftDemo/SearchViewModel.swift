//
//  SearchViewModel.swift
//  RxSwiftDemo
//
//  Created by Shuhei Kawaguchi on 2016/03/29.
//  Copyright © 2016年 Shuhei Kawaguchi. All rights reserved.
//

import UIKit
import APIKit

class SearchViewModel: NSObject {
    var repositories: [Repository]!
    
    func request() -> [Repository]? {
        var repo: [Repository]?
        let request = SearchRepositoriesRequest(query: "Swift")
        Session.sendRequest(request) { result in
            switch result {
            case .Success(let response):
                repo = response.repository
                print(repo)
                
            case .Failure(let error):
                print(error)
                repo = nil
            }
        }
        return repo
    }
}
