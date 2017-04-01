//
//  URLParametersTransformable.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 21.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

protocol URLParametersTransformable {
    func toDictionary() -> [String: String]
}

extension URLParametersTransformable {
    
    func stringQuery(fromStringArray array: [String], withSeprator separator: String) -> String {
        var query = array.reduce("") { result, element in
            return result + element + separator
        }
        query.remove(at: query.index(before: query.endIndex))
        
        return query
    }
}
