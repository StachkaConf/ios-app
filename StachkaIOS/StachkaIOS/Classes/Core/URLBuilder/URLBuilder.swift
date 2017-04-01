//
//  URLBuilder.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 21.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

protocol URLBuilderConfiguration {}

protocol URLBuilder {
    
    func build(withAPIPath path: NetworkRequestConstants.APIPath,
               APIMethod method: NetworkRequestConstants.APIMethodName,
               configuration: URLBuilderConfiguration) throws -> URL
}
