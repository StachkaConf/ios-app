//
//  RequestBuilderImplementation.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 21.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

class RequestBuilderImplementation: RequestBuilder {
    
    func build(_ configuration: RequestBuilderConfiguration) -> URLRequest {
        var request = URLRequest(url: configuration.url,
                                 cachePolicy: .useProtocolCachePolicy,
                                 timeoutInterval: configuration.timoutInterval)
        
        request.httpMethod = configuration.method.rawValue
        addHeaders(to: &request)
        addAuthorization(to: &request, configuration: configuration)
        
        return request
    }
    
    func addHeaders(to request: inout URLRequest) {
        request.setValue("application/json", forHTTPHeaderField: NetworkRequestConstants.HeaderName.contentType.rawValue)
        request.setValue("application/json", forHTTPHeaderField: NetworkRequestConstants.HeaderName.accept.rawValue)
    }

    func addAuthorization(to request: inout URLRequest, configuration: RequestBuilderConfiguration) {
        let loginString = String(format: "%@:%@", configuration.username, configuration.password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
    }
}
