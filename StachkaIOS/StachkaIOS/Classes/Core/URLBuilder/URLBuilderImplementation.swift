//
//  URLBuilderImplementation.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 21.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

class URLBuilderImplementation: URLBuilder {
    
    // MARK: - Методы URLBuilder
    
    func build(withAPIPath path: NetworkRequestConstants.APIPath,
               APIMethod method: NetworkRequestConstants.APIMethodName,
               configuration: URLBuilderConfiguration) throws -> URL {
        let urlString = path.rawValue + method.rawValue
        
        if let parametersTransformable = configuration as? URLParametersTransformable {
            return try url(fromBaseUrlString: urlString, parameters: parametersTransformable.toDictionary())
        } else {
            throw NetworkRequestError.urlConfigurationParserNotImplemented
        }
    }
    
    // MARK: - Приватные методы
    
    private func url(fromBaseUrlString urlString: String, parameters: [String: String]) throws -> URL {
        var urlComponents = URLComponents(string: urlString)
        var queryItems: [URLQueryItem] = []
        
        for (key, value) in parameters {
            let newItem = URLQueryItem(name: key, value: value)
            queryItems.append(newItem)
        }
        urlComponents?.queryItems = queryItems
        guard let url = urlComponents?.url else {
            throw NetworkRequestError.cannotBuildFromComponents
        }
        
        return url
    }
}
