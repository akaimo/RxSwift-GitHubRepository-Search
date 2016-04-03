//
//  Repository.swift
//  RxSwiftDemo
//
//  Created by Shuhei Kawaguchi on 2016/03/29.
//  Copyright © 2016年 Shuhei Kawaguchi. All rights reserved.
//

import Foundation
import Himotoki

struct Repository: Decodable {
    let id: Int
    let fullName: String
    let stargazersCount: Int
    
    static func decode(e: Extractor) throws -> Repository {
        return try Repository(
            id:              e <| "id",
            fullName:        e <| "full_name",
            stargazersCount: e <| "stargazers_count"
        )
    }
}