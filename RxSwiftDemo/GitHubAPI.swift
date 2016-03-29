//
//  GithubAPI.swift
//  RxSwiftDemo
//
//  Created by Shuhei Kawaguchi on 2016/03/29.
//  Copyright © 2016年 Shuhei Kawaguchi. All rights reserved.
//

import Foundation
import APIKit

protocol GitHubAPI: RequestType {
    
}

extension GitHubAPI {
    var baseURL: NSURL {
        return NSURL(string: "https://api.github.com")!
    }
}