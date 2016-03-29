//
//  SearchResult.swift
//  RxSwiftDemo
//
//  Created by Shuhei Kawaguchi on 2016/03/29.
//  Copyright © 2016年 Shuhei Kawaguchi. All rights reserved.
//

import Foundation
import Himotoki

struct SearchRepositoryResult: Decodable {
    let total_count: Int
    let incomplete_results: Bool
    let repository: [Repository]
    
    static func decode(e: Extractor) throws -> SearchRepositoryResult {
        return try SearchRepositoryResult(
            total_count: e <| "total_count",
            incomplete_results: e <| "incomplete_results",
            repository: e <|| "items"
        )
    }
}
