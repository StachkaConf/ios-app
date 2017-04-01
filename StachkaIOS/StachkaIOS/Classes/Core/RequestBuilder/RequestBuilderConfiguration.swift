//
//  RequestBuilderConfiguration.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 21.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

struct RequestBuilderConfiguration {
    let method: NetworkRequestConstants.HTTPMethod
    let timoutInterval: Double
    let url: URL
}
