//
//  RequestBuilder.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 21.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

protocol RequestBuilder {
    func build(_ configuration: RequestBuilderConfiguration) -> URLRequest
}
